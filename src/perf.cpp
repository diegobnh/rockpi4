#include "perf.hpp"
#include <cassert>
#include <cstdio>
#include <cstdlib>
#include <cstring>
#include <limits>
#include <unistd.h>
#include <asm/unistd.h>
#include <sys/ioctl.h>
#include <sys/sysinfo.h>
#include <linux/perf_event.h>


//sure you have exactly 10 lines and 6 columns per line because the variable "curr_index_pmc_a72" assumed it configuration.
int64_t pmcs_a53[]={0x00,0x01,0x02,0x03,0x04,0x05,
                    0x06,0x07,0x08,0x09,0x0A,0x0B,
                    0x0C,0x0D,0x0E,0x0F,0x10,0x11,
                    0x12,0x13,0x14,0x15,0x16,0x17,
                    0x18,0x19,0x1A,0x1B,0x1C,0x1D,
                    0x1E,0x1F,0x20,0x21,0x22,0x23,
                    0x24,0x25,0x26,0x27,0x28,0x29,
                    0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,
                    0x30,0x31,0x32,0x33,0x34,0x35,
                    0x36,0x37,0x38,0x40,0x41,0x42,
                    0x43,0x44,0x45,0x46,0x47,0x48,
                    0x4C,0x4D,0x4E,0x4F,0x50,0x51,
                    0x52,0x53,0x56,0x57,0x58,0x5C,
                    0x5D,0x5E,0x5F,0x60,0x61,0x62,
                    0x63,0x64,0x65,0x66,0x67,0x68,
                    0x69,0x6A,0x6C,0x6D,0x6E,0x6F,
                    0x70,0x71,0x72,0x73,0x74,0x75,
                    0x76,0x77,0x78,0x79,0x7A,0x7C,
                    0x7D,0x7E,0x81,0x82,0x83,0x84,
                    0x86,0x87,0x88,0x8A,0x8B,0x8C,
                    0x8D,0x8E,0x8F,0x90,0x91,0xA0,
                    0xA1,0xA2,0xA3,0xA6,0xA7,0xA8}; //22x6


//sure you have exactly 9 lines and 4 columns per line because variable "curr_index_pmc_a53" assumed it configuration.
int64_t pmcs_a72[]={0x00,0x01,0x02,0x03,0x04,0x05,
                    0x06,0x07,0x08,0x09,0x0A,0x0B,
                    0x0C,0x0D,0x0E,0x0F,0x10,0x11,
                    0x12,0x13,0x14,0x15,0x16,0x17,
                    0x18,0x19,0x1A,0x1B,0x1C,0x1D,
                    0x1E,0x1F,0x20,0x21,0x22,0x23,
                    0x24,0x25,0x26,0x27,0x28,0x29,
                    0x2A,0x2B,0x2C,0x2D,0x2E,0x2F,
                    0x30,0x31,0x32,0x33,0x34,0x35,
                    0x36,0x37,0x38,0x40,0x41,0x42,
                    0x43,0x44,0x45,0x46,0x47,0x48,
                    0x4C,0x4D,0x4E,0x4F,0x50,0x51,
                    0x52,0x53,0x56,0x57,0x58,0x5C,
                    0x5D,0x5E,0x5F,0x60,0x61,0x62,
                    0x63,0x64,0x65,0x66,0x67,0x68,
                    0x69,0x6A,0x6C,0x6D,0x6E,0x6F,
                    0x70,0x71,0x72,0x73,0x74,0x75,
                    0x76,0x77,0x78,0x79,0x7A,0x7C,
                    0x7D,0x7E,0x81,0x82,0x83,0x84,
                    0x86,0x87,0x88,0x8A,0x8B,0x8C,
                    0x8D,0x8E,0x8F,0x90,0x91,0xA0,
                    0xA1,0xA2,0xA3,0xA6,0xA7,0xA8}; //22X6

/// Maximum events that can be recorded simultaneously.
///
/// The Cortex A53 is a limiting factor here because it contains
/// only six performance counting registers.
constexpr int MAX_EVENTS_PER_GROUP = 7;

/// Maximum number of processor cores we are going to use.
constexpr int MAX_PROCESSORS = 6;

/// Number of software counters to collect.
constexpr int NUM_SOFTWARE_COUNTERS = 2;

struct PerfEvent
{
    int fd;
    uint64_t id;
    uint64_t prev_value;
};

static PerfEvent perf_cpu[MAX_PROCESSORS][MAX_EVENTS_PER_GROUP];
static PerfEvent perf_sw[MAX_PROCESSORS][NUM_SOFTWARE_COUNTERS];
static int num_processors;


void perf_init()
{

    static int curr_index_pmc_a72 = 0;
    static int curr_index_pmc_a53 = 0;

    auto perf_event_open = [](struct perf_event_attr *hw_event, pid_t pid,
                               int cpu, int group_fd, unsigned long flags) {
        return syscall(__NR_perf_event_open, hw_event, pid, cpu,
                       group_fd, flags);
    };

    num_processors = get_nprocs_conf();
    assert(num_processors <= MAX_PROCESSORS);

    //fprintf(stderr, "scheduler: detected %d processors\n", num_processors);

//#ifdef PMCS_A53_ONLY
#if PMC_TYPE == PMCS_A53_ONLY
    for(int cpu = START_INDEX_LITTLE; cpu <= END_INDEX_LITTLE; ++cpu)
    {
        for(int i = 0; i < MAX_EVENTS_PER_GROUP; ++i)
        {
            uint64_t config;
            int group_fd;
            struct perf_event_attr pe;
            memset(&pe, 0, sizeof(pe));


            switch(i)
            {
                case 0:
                    config = PERF_COUNT_HW_CPU_CYCLES; //0x11
                    group_fd = -1;
                    pe.type = PERF_TYPE_HARDWARE;
                    break;
                case 1:
                    config = pmcs_a53[curr_index_pmc_a53];
                    group_fd = perf_cpu[cpu][0].fd;
                    pe.type = PERF_TYPE_RAW;
                    break;
                case 2:
                    config = pmcs_a53[curr_index_pmc_a53+1];
                    group_fd = perf_cpu[cpu][0].fd;
                    pe.type = PERF_TYPE_RAW;
                    break;
                case 3:
                    config = pmcs_a53[curr_index_pmc_a53+2];
                    group_fd = perf_cpu[cpu][0].fd;
                    pe.type = PERF_TYPE_RAW;
                    break;
                case 4:
                    config = pmcs_a53[curr_index_pmc_a53+3];
                    group_fd = perf_cpu[cpu][0].fd;
		    pe.type = PERF_TYPE_RAW;
                    break;
                case 5:
                    config = pmcs_a53[curr_index_pmc_a53+4];
                    group_fd = perf_cpu[cpu][0].fd;
                    pe.type = PERF_TYPE_RAW;
                    break;
                case 6:
                    config = pmcs_a53[curr_index_pmc_a53+5];
                    group_fd = perf_cpu[cpu][0].fd;
                    pe.type = PERF_TYPE_RAW;
                    break;

                default:
                    perf_cpu[cpu][i].fd = -1;
                    perf_cpu[cpu][i].id = -1;
		    pe.type = PERF_TYPE_RAW;
                    continue;
            }

            pe.size = sizeof(pe);
            //pe.type = PERF_TYPE_RAW;
            pe.config = config;
            pe.exclude_hv = true;
            pe.exclude_kernel = true;
            pe.disabled = true;
            pe.read_format = PERF_FORMAT_ID | PERF_FORMAT_GROUP;

            const auto fd = perf_event_open(&pe, -1, cpu, group_fd, 0);
            if(fd == -1)
            {
                perror("scheduler: failed to initialise perf");
                abort();
            }

            perf_cpu[cpu][i].fd = fd;
            ioctl(fd, PERF_EVENT_IOC_ID, &perf_cpu[cpu][i].id);
            ioctl(fd, PERF_EVENT_IOC_RESET, 0);
            perf_cpu[cpu][i].prev_value = 0;
        }
    }
    curr_index_pmc_a53 +=6;
#endif

//#ifdef PMCS_A72_ONLY
#if PMC_TYPE == PMCS_A72_ONLY
    for(int cpu = START_INDEX_BIG; cpu <= END_INDEX_BIG; ++cpu)
    {
        for(int i = 0; i < MAX_EVENTS_PER_GROUP; ++i)
        {
            uint64_t config;
            int group_fd;
            struct perf_event_attr pe;
            memset(&pe, 0, sizeof(pe));


            switch(i)
            {
                case 0:
		    config = PERF_COUNT_HW_CPU_CYCLES;
		    group_fd = -1;
                    pe.type = PERF_TYPE_HARDWARE;
		    break;
                case 1:
                    config = pmcs_a72[curr_index_pmc_a72];
		    group_fd = perf_cpu[cpu][0].fd;
                    pe.type = PERF_TYPE_RAW;
		    break;
                case 2:
                    config = pmcs_a72[curr_index_pmc_a72+1];
		    group_fd = perf_cpu[cpu][0].fd;
                    pe.type = PERF_TYPE_RAW;
		    break;
		case 3:
                    config = pmcs_a72[curr_index_pmc_a72+2];
		    group_fd = perf_cpu[cpu][0].fd;
                    pe.type = PERF_TYPE_RAW;
		    break;
		case 4:
                    config = pmcs_a72[curr_index_pmc_a72+3];
		    group_fd = perf_cpu[cpu][0].fd;
                    pe.type = PERF_TYPE_RAW;
		    break;
                case 5:
                    config = pmcs_a72[curr_index_pmc_a72+4];
		    group_fd = perf_cpu[cpu][0].fd;
                    pe.type = PERF_TYPE_RAW;
                    break;
                case 6:
                    config = pmcs_a72[curr_index_pmc_a72+5];
		    group_fd = perf_cpu[cpu][0].fd;
                    pe.type = PERF_TYPE_RAW;
                    break;
                default:
		    perf_cpu[cpu][i].fd = -1;
		    perf_cpu[cpu][i].id = -1;
                    pe.type = PERF_TYPE_RAW;
		    continue;
            }

            pe.size = sizeof(pe);
            //pe.type = PERF_TYPE_RAW;
            pe.config = config;
            pe.exclude_hv = true;
            pe.exclude_kernel = true;
            pe.disabled = true;
            pe.read_format = PERF_FORMAT_ID | PERF_FORMAT_GROUP;

            const auto fd = perf_event_open(&pe, -1, cpu, group_fd, 0);
            if(fd == -1)
            {
                perror("scheduler: failed to initialise perf");
                abort();
            }

            perf_cpu[cpu][i].fd = fd;
            ioctl(fd, PERF_EVENT_IOC_ID, &perf_cpu[cpu][i].id);
            ioctl(fd, PERF_EVENT_IOC_RESET, 0);
            perf_cpu[cpu][i].prev_value = 0;
        }
    }
    curr_index_pmc_a72 +=6;

#endif
    for(int cpu = 0; cpu < num_processors; ++cpu)
    {

        for(int i = 0; i < NUM_SOFTWARE_COUNTERS; ++i)
        {
                uint64_t config;
                int group_fd;

                switch(i)
                {
                        case 0:
	                    config = PERF_COUNT_SW_CPU_MIGRATIONS;
	                    group_fd = -1;
                            //group_fd = perf_sw[cpu][0].fd;
	                    break;
                        case 1:
	                    config = PERF_COUNT_SW_CONTEXT_SWITCHES;
	                    group_fd = perf_sw[cpu][0].fd;
	                    break;
                        default:
	                    perf_sw[cpu][i].fd = -1;
	                    perf_sw[cpu][i].id = -1;
	                    continue;
                }

                struct perf_event_attr pe;
                memset(&pe, 0, sizeof(pe));
                pe.size = sizeof(pe);
                pe.type = PERF_TYPE_SOFTWARE;
                pe.config = config;
                pe.exclude_hv = true;
                pe.exclude_kernel = false;
                pe.disabled = true;
                pe.read_format = PERF_FORMAT_ID | PERF_FORMAT_GROUP;

                const auto fd = perf_event_open(&pe, -1, cpu, group_fd, 0);
                if(fd == -1)
                {
                     perror("scheduler: failed to initialise perf");
                     abort();
                }

                perf_sw[cpu][i].fd = fd;
                ioctl(fd, PERF_EVENT_IOC_ID, &perf_sw[cpu][i].id);
                ioctl(fd, PERF_EVENT_IOC_RESET, 0);
                perf_sw[cpu][i].prev_value = 0;
          }
    }

    for(int cpu = 0; cpu < num_processors; ++cpu)
    {
        const auto leader_fd = perf_cpu[cpu][0].fd;
        ioctl(leader_fd, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP);
    }

    for(int cpu = 0; cpu < num_processors; ++cpu)
    {
        const auto leader_fd = perf_sw[cpu][0].fd;
        ioctl(leader_fd, PERF_EVENT_IOC_ENABLE, PERF_IOC_FLAG_GROUP);
    }

}

void perf_shutdown()
{
    for(int cpu = 0; cpu < num_processors; ++cpu)
    {
        for(int i = 0; i < MAX_EVENTS_PER_GROUP; ++i)
        {
            const auto fd = perf_cpu[cpu][i].fd;
            if(fd != -1)
            {
                close(perf_cpu[cpu][i].fd);
                perf_cpu[cpu][i].fd = -1;
                perf_cpu[cpu][i].id = -1;
                perf_cpu[cpu][i].prev_value = 0;
            }
        }
    }


    for(int cpu = 0; cpu < num_processors; ++cpu)
    {

        for(int i = 0; i < NUM_SOFTWARE_COUNTERS; ++i)
        {
            close(perf_sw[cpu][i].fd);
            perf_sw[cpu][i].fd = -1;
            perf_sw[cpu][i].id = -1;
            perf_sw[cpu][i].prev_value = 0;
        }
    }
}

int perf_nprocs()
{
    return num_processors;
}

auto perf_consume_hw(int cpu) -> PerfHardwareData
{
    struct
    {
        uint64_t nr;    /* The number of events */
        struct {
            uint64_t value; /* The value of the event */
            uint64_t id;    /* if PERF_FORMAT_ID */
        } values[MAX_EVENTS_PER_GROUP];
    } data;


    assert(cpu < num_processors);

    const auto fd = perf_cpu[cpu][0].fd;

    if(fd == -1)
        return PerfHardwareData{};

    if(read(fd, &data, sizeof(data)) == -1)
    {
        perror("scheduler: failed to read hardware counters");
        abort();
    }

    uint64_t counters[MAX_EVENTS_PER_GROUP];
    memset(counters, -1, sizeof(counters));


    for(uint64_t s = 0; s < data.nr; ++s)
    {
        for(int pi = 0; pi < MAX_EVENTS_PER_GROUP; ++pi)
        {
            if(data.values[s].id == perf_cpu[cpu][pi].id)
            {
                const auto value = data.values[s].value;
                const auto prev_value = perf_cpu[cpu][pi].prev_value;
                const auto u64_max = std::numeric_limits<uint64_t>::max();

                if(value >= prev_value)
                {
                    counters[pi] = value - prev_value;
                }
                else
                {
                    counters[pi] = 0;
                    counters[pi] += u64_max - prev_value;
                    counters[pi] += value;
                }

                perf_cpu[cpu][pi].prev_value = value;
            }
        }
    }


    return PerfHardwareData {
        counters[0],
        counters[1],
        counters[2],
        counters[3],
	counters[4],
        counters[5],
        counters[6],
    };
}

auto perf_consume_sw(int cpu) -> PerfSoftwareData
{
    struct
    {
        uint64_t nr;    /* The number of events */
        struct {
            uint64_t value; /* The value of the event */
            uint64_t id;    /* if PERF_FORMAT_ID */
        } values[NUM_SOFTWARE_COUNTERS];
    } data;

    assert(cpu < num_processors);

    const auto fd = perf_sw[cpu][0].fd;

    if(fd == -1)
        return PerfSoftwareData{};

    if(read(fd, &data, sizeof(data)) == -1)
    {
        perror("scheduler: failed to read software counters");
        abort();
    }

    uint64_t counters[NUM_SOFTWARE_COUNTERS];
    memset(counters, -1, sizeof(counters));

    for(uint64_t s = 0; s < data.nr; ++s)
    {
        for(int pi = 0; pi < NUM_SOFTWARE_COUNTERS; ++pi)
        {
            if(data.values[s].id == perf_sw[cpu][pi].id)
            {
                const auto value = data.values[s].value;
                const auto prev_value = perf_sw[cpu][pi].prev_value;
                const auto u64_max = std::numeric_limits<uint64_t>::max();

                if(value >= prev_value)
                {
                    counters[pi] = value - prev_value;
                }
                else
                {
                    counters[pi] = 0;
                    counters[pi] += u64_max - prev_value;
                    counters[pi] += value;
                }

                perf_sw[cpu][pi].prev_value = value;
            }
        }
    }

    return PerfSoftwareData {
        counters[0],
        counters[1],
    };
}
