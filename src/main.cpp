
#include <cstdio>
#include <stdio.h>
#include <cstdlib>
#include <cstdarg>
#include <cassert>
#include <cinttypes>
#include <cstring>
#include <unistd.h>
#include <sys/wait.h>
#include <sys/prctl.h>
#include <linux/limits.h>
#include <signal.h>
#include "perf.hpp"
#include "time.hpp"
#include "states.hpp"
#include <fcntl.h>    /* For O_RDWR */

#define NUM_EXEC_GET_ALL_PMCS 22
#define FLAG_ONLY_PARALLEL_REGION 0

#ifndef PMC_TYPE
#   error Please define PMC_TYPE
#endif

#if !(PMC_TYPE == 53 || PMC_TYPE == 72)
#   error PMC_TYPE must be 53 or 72
#endif

char pmcs[][35]={ "0x00_0x01_0x02_0x03_0x04_0x05",
                  "0x06_0x07_0x08_0x09_0x0A_0x0B",
                  "0x0C_0x0D_0x0E_0x0F_0x10_0x11",
                  "0x12_0x13_0x14_0x15_0x16_0x17",
                  "0x18_0x19_0x1A_0x1B_0x1C_0x1D",
                  "0x1E_0x1F_0x20_0x21_0x22_0x23",
                  "0x24_0x25_0x26_0x27_0x28_0x29",
                  "0x2A_0x2B_0x2C_0x2D_0x2E_0x2F",
                  "0x30_0x31_0x32_0x33_0x34_0x35",
                  "0x36_0x37_0x38_0x40_0x41_0x42",
                  "0x43_0x44_0x45_0x46_0x47_0x48",
                  "0x4C_0x4D_0x4E_0x4F_0x50_0x51",
                  "0x52_0x53_0x56_0x57_0x58_0x5C",
                  "0x5D_0x5E_0x5F_0x60_0x61_0x62",
                  "0x63_0x64_0x65_0x66_0x67_0x68",
                  "0x69_0x6A_0x6C_0x6D_0x6E_0x6F",
                  "0x70_0x71_0x72_0x73_0x74_0x75",
                  "0x76_0x77_0x78_0x79_0x7A_0x7C",
                  "0x7D_0x7E_0x81_0x82_0x83_0x84",
                  "0x86_0x87_0x88_0x8A_0x8B_0x8C",
                  "0x8D_0x8E_0x8F_0x90_0x91_0xA0",
                  "0xA1_0xA2_0xA3_0xA6_0xA7_0xA8"};

char** environ;
static FILE* pmcs_stream = 0;
static FILE* cpu_utilization_stream = 0;
static int application_pid = -1;
static uint64_t application_start_time = 0;
static State current_state;
static int num_time_steps = 0;
static int flag_update_schedule;
static int power_monitor_fd = -1;
static int power_monitor_pid = -1;
static int parallel_region = 1;
static int index_pmc = 0;


static void cleanup()
{
    if(application_pid != -1)
    {
        kill(application_pid, SIGTERM);
        waitpid(application_pid, nullptr, 0);
        application_pid = -1;
    }

    if(pmcs_stream != 0)
    {
        fclose(pmcs_stream);
        pmcs_stream = 0;
    }
}

static bool create_logging_file()
{
    char filename[PATH_MAX];

#if FLAG_ONLY_PARALLEL_REGION == 1
    sprintf(filename, "Region_%d_%s.csv", parallel_region,pmcs[index_pmc]); //getpid() get fathers'pid
#elif PMC_TYPE == PMCS_A53_ONLY || PMC_TYPE == PMCS_A72_ONLY
    if(index_pmc >=0 && index_pmc<NUM_EXEC_GET_ALL_PMCS){
       sprintf(filename, "%s.csv", pmcs[index_pmc]);
    }
#else
    sprintf(filename, "scheduler_%d.csv", application_pid); //getpid() get fathers'pid
#endif

    pmcs_stream = fopen(filename, "w");
    if(!pmcs_stream)
    {
        perror("scheduler: failed to open logging file");
        return false;
    }
    fprintf(stderr, "scheduler: collecting pmcs %s\n", filename);

    return true;
}

static bool spawn_power_monitor(void)
{
    int out = open("out_energy.txt", O_RDWR | O_CREAT, S_IRUSR | S_IWUSR);

    int pid = fork();
    if(pid == -1)
    {
        perror("scheduler: failed to fork scheduler");
        return false;
    }
    else if(pid == 0)
    {
        dup2(out,1);

        char *args[] = {(char *)"sudo", "grabserial", "-T", "-d", "/dev/ttyUSB0", NULL};
        execvp(args[0],args);
        perror("scheduler: execvp failed on wattsup !\n");
        return false;

    }
    else
    {
        ::power_monitor_fd = out;
        ::power_monitor_pid = pid;
        //fprintf(stderr, "pid power monitor:%d\n", power_monitor_pid);
        return true;
    }
}

static bool spawn_application(char* argv[])
{
    int pid = fork();
    if(pid == -1)
    {
        perror("scheduler: failed to fork scheduled application");
        return false;
    }
    else if(pid == 0)
    {
        execvp(argv[0], argv);
        perror("scheduler: execvp failed");
        return false;
    }
    else
    {
        ::application_pid = pid;
        ::application_start_time = get_time();
        ::current_state = STATE_4l2b;//We always start using all resources!!
        return true;
    }
}

void get_cpu_usage(double *cpu_usage)
{
    if(::application_pid == -1)
    {
        cpu_usage[0] = 0.0;
        cpu_usage[1] = 0.0;
        return;
    }

    int count = 0;
    char buffer[256];
    sprintf(buffer, "ps -p %d -mo pcpu,psr", ::application_pid);
    cpu_utilization_stream = popen(buffer, "r");
    if(!cpu_utilization_stream)
    {
        perror("failed to collect cpu usage");
        cpu_usage[0] = 0.0;
        cpu_usage[1] = 0.0;
        return;
    }

    double total_cluster_little = 0.0;
    double total_cluster_big    = 0.0;

    // skip %CPU
    count = 0;
    buffer[0] = 0;
    while(count == 0 || buffer[count-1] != '\n')
    {
        if(!fgets(&buffer[count], sizeof(buffer), cpu_utilization_stream))
            break;
        count = strlen(buffer);
    }

    // skip total
    count = 0;
    buffer[0] = 0;
    while(count == 0 || buffer[count-1] != '\n')
    {
        if(!fgets(&buffer[count], sizeof(buffer), cpu_utilization_stream))
            break;
        count = strlen(buffer);
    }

    // iterate on the next lines
    while(true)
    {
        count = 0;
        buffer[0] = 0;
        while(count == 0 || buffer[count-1] != '\n')
        {
            if(!fgets(&buffer[count], sizeof(buffer), cpu_utilization_stream))
                break;
            count = strlen(buffer);
        }

        if(count == 0)
            break;

        double row_cpu_usage;
        int row_cpu_core;
        sscanf(buffer, "%lf %d", &row_cpu_usage, &row_cpu_core);

        if(row_cpu_core >= 0 && row_cpu_core <= 3)
            total_cluster_little += row_cpu_usage;
        else
            total_cluster_big += row_cpu_usage;
    }

    fclose(cpu_utilization_stream);

    cpu_usage[0] = total_cluster_little;
    cpu_usage[1] = total_cluster_big;

}

static void update_scheduler()
{
    time_t rawtime;
    struct tm *info;
    char time_str[256];

    double cpu_usage[2];

    double l_pmc_1 = 0;
    double l_pmc_2 = 0;
    double l_pmc_3 = 0;
    double l_pmc_4 = 0;
    double l_pmc_5 = 0;
    double l_pmc_6 = 0;
    double l_pmc_7 = 0;

    double b_pmc_1 = 0;
    double b_pmc_2 = 0;
    double b_pmc_3 = 0;
    double b_pmc_4 = 0;
    double b_pmc_5 = 0;
    double b_pmc_6 = 0;
    double b_pmc_7 = 0;

    /*
    char buffer[250];
    float energy=0.0;
    scanf("%s", buffer);
    sscanf(buffer, "%f", &energy);
    */
#if PMC_TYPE == PMCS_A53_ONLY
    //l_pmc or b_pmc are sum all core in cluster
    for(int cpu = START_INDEX_LITTLE; cpu <= END_INDEX_LITTLE; ++cpu)
    {
        const auto hw_data = perf_consume_hw(cpu);
        l_pmc_1 += (double)hw_data.pmc_1;
        l_pmc_2 += (double)hw_data.pmc_2;
        l_pmc_3 += (double)hw_data.pmc_3;
        l_pmc_4 += (double)hw_data.pmc_4;
        l_pmc_5 += (double)hw_data.pmc_5;
        l_pmc_6 += (double)hw_data.pmc_6;
        l_pmc_7 += (double)hw_data.pmc_7;

    }
#elif PMC_TYPE == PMCS_A72_ONLY
    for(int cpu = START_INDEX_BIG; cpu <= END_INDEX_BIG; ++cpu)
    {
        const auto hw_data = perf_consume_hw(cpu);
        b_pmc_1 += (double)hw_data.pmc_1;
        b_pmc_2 += (double)hw_data.pmc_2;
        b_pmc_3 += (double)hw_data.pmc_3;
        b_pmc_4 += (double)hw_data.pmc_4;
        b_pmc_5 += (double)hw_data.pmc_5;
        b_pmc_6 += (double)hw_data.pmc_6;
        b_pmc_7 += (double)hw_data.pmc_7;
    }
#endif

    /*
    double total_cpu_migration = 0;
    double total_context_switch = 0;


    for(int cpu = 0, max_cpu = perf_nprocs(); cpu < max_cpu; ++cpu)
    {
        const auto sw_data = perf_consume_sw(cpu);
        total_cpu_migration += (double)sw_data.cpu_migrations;
        total_context_switch += (double)sw_data.context_switches;
    }
    */

    const uint64_t elapsed_time = to_millis(get_time() - ::application_start_time);
    State next_state = current_state;

    time(&rawtime);
    info = localtime(&rawtime);
    sprintf(time_str, "[%02d:%02d:%02d]",info->tm_hour, info->tm_min, info->tm_sec);

    get_cpu_usage(cpu_usage);

#if PMC_TYPE == PMCS_A53_ONLY
    fprintf(pmcs_stream,"%s,%.4lf,%.4lf,%.4lf,%.4lf,%.4lf,%.4lf,%.4lf,%.4lf,%.4lf\n",\
            time_str,l_pmc_1, l_pmc_2, l_pmc_3, l_pmc_4, l_pmc_5, l_pmc_6, l_pmc_7, \
            cpu_usage[0], cpu_usage[1]); //energy

#elif PMC_TYPE == PMCS_A72_ONLY
    fprintf(pmcs_stream,"%s,%.4lf,%.4lf,%.4lf,%.4lf,%.4lf,%.4lf,%.4lf,%.4lf,%.4lf\n",\
            time_str,b_pmc_1, b_pmc_2, b_pmc_3, b_pmc_4, b_pmc_5, b_pmc_6, b_pmc_7, \
            cpu_usage[0], cpu_usage[1]);//energy

#endif

}


/*
 *
 * This function we can use for collect pmcs just when the application send an signal.
 * For this we need to instrument the application. For example:
 *
 *    kill(getppid(), SIGUSR1);
      #pragma omp parallel
      {
            int tid;
            tid = omp_get_thread_num();
            printf("Hello World from thread = %d\n", tid);
            sleep(3);
      }
      kill(getppid(), SIGUSR2);
 * */

void sig_handler(int signo)
{
    if (signo == SIGUSR1){
        if(!create_logging_file())
        {
           cleanup();
        }

        //fprintf(stderr, "received SIGUSR1..starting the collect\n");
        if(FLAG_ONLY_PARALLEL_REGION == 1){
           update_scheduler();
           ::flag_update_schedule = 0;
        }

    }
    else if (signo == SIGUSR2){
       if(::pmcs_stream != 0)
       {
          fclose(pmcs_stream);
          ::pmcs_stream = 0;
       }
       //fprintf(stderr, "received SIGUSR2..stoping the collect\n");

       if(FLAG_ONLY_PARALLEL_REGION == 1){
          ::flag_update_schedule = 1;
          ::parallel_region++;
       }
    }
}


int main(int argc, char* argv[])
{
    FILE *pf=NULL;
    time_t rawtime;
    struct tm *info;
    char time_start[256], time_end[256];

    ::flag_update_schedule = FLAG_ONLY_PARALLEL_REGION ;

#if FLAG_ONLY_PARALLEL_REGION == 1
    signal(SIGUSR1, sig_handler);
    signal(SIGUSR2, sig_handler);
#endif

    pf = fopen("ExecutionTimes.txt", "w");
    if(pf == NULL)
      fprintf(stderr, "Fail to open file\n");

    if(argc < 2)
    {
        fprintf(stderr, "usage: %s command args...\n", argv[0]);
        return 1;
    }

    fprintf(stderr, "Application:%s\n", argv[1]);

    const int num_episodes = 22;//number of time to collect all pmcs from big core

    for(int curr_episode = 0; curr_episode < NUM_EXEC_GET_ALL_PMCS; ++curr_episode)
    {

        //spawn_power_monitor();
        //sleep(1);

        perf_init();
        sleep(1);

#if FLAG_ONLY_PARALLEL_REGION == 0
        if(!create_logging_file())
        {
            cleanup();
            return 1;
        }
#endif

        time(&rawtime);
        info = localtime(&rawtime);
        sprintf(time_start, "[%02d:%02d:%02d]",info->tm_hour, info->tm_min, info->tm_sec);

        if(!spawn_application(&argv[1]))
        {
            cleanup();
            return 1;
        }

        while(::application_pid != -1)
        {
            int pid = waitpid(::application_pid, NULL, WNOHANG);

            if(pid == -1)
            {
                perror("scheduler: waitpid in main loop failed");
            }
            else if(pid != 0)
            {
                assert(pid == ::application_pid);
                application_pid = -1;

            }
            else if(!(flag_update_schedule == 1))
            {
                update_scheduler();
            }
            usleep(200000);//200 miliseconds
        }

        time(&rawtime);
        info = localtime(&rawtime);
        sprintf(time_end, "[%02d:%02d:%02d]",info->tm_hour, info->tm_min, info->tm_sec);
        fprintf(pf, "%s,%s\n",time_start,time_end);

        perf_shutdown();

        /*
        Enable when powerMonitor is working
        sleep(1);
        system("sudo kill -9 `ps -aux | grep grabserial | awk '{ print $2; }'`");
        power_monitor_pid = -1;
        power_monitor_fd = -1;

        char cmd[256];
        sprintf(cmd, "mv out_energy.txt %s.energy", pmcs[curr_episode]);
        int ret = system(cmd);
        */
        cleanup();
        ::index_pmc++;
#if FLAG_ONLY_PARALLEL_REGION == 1
        ::parallel_region = 1;
#endif
        usleep(2000000); //only to clear anything in cpu - 2 seconds

    }
    fclose(pf);

    return 0;
}
