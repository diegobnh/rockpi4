#include "ep_pre.h"
typedef int boolean;

void ctrl_c_handler(int s);
void energymonitor__initialize();
void energymonitor__setfilename(char *profFileName);
void energymonitor__saveascsv(char *profFileName);
void energymonitor__saveastextfile(char* profFileName);
void energymonitor__init(int cores,float sleeptime);
void energymonitor__setsleeptime(float time);
void energymonitor__startprofiling();
void energymonitor__stopprofiling();
void energymonitor__pauseprofiling();
void energymonotor__upauseprofiling();
void energymonitor__trackpoweronly();
void energymonitor__trackvoltage();
void energymonitor__trackeverything();
int energymonitor__runfunction();
void energymonitor__settrackingcores(int cores);
void* energymonitor__startprofilingthread(void* threadid);
int cores = 255;
static double x[2*(1 << 16)];
        
#pragma omp threadprivate(x)
static double q[10];
int main(int argc, char **argv) {
    double Mops, t1, t2, t3, t4, x1, x2, sx, sy, tm, an, tt, gc;
    double dum[3] = { 1.0, 1.0, 1.0 };
    int np, ierr, node, no_nodes, i, ik, kk, l, k, nit, ierrcode,
 no_large_nodes, np_add, k_offset, j;
    int nthreads = 1;
    boolean verified;
    char size[13+1];
    printf("\n\n NAS Parallel Benchmarks 2.3 OpenMP C version"
    " - EP Benchmark\n");
    sprintf(size, "%12.0f", pow(2.0, 28 +1));
    for (j = 13; j >= 1; j--) {
 if (size[j] == '.') size[j] = ' ';
    }
    printf(" Number of random numbers generated: %13s\n", size);
    verified = 0;
    np = (1 << (28 - 16));
    vranlc(0, &(dum[0]), dum[1], &(dum[2]));
    dum[0] = randlc(&(dum[1]), dum[2]);
    for (i = 0; i < 2*(1 << 16); i++) x[i] = -1.0e99;
    Mops = log(sqrt(fabs((((1.0) > (1.0)) ? (1.0) : (1.0)))));
    timer_clear(1);
    timer_start(1);
    vranlc(0, &t1, 1220703125.0, x);
    t1 = 1220703125.0;
    for ( i = 1; i <= 16 +1; i++) {
 t2 = randlc(&t1, t1);
    }
    an = t1;
    tt = 271828183.0;
    gc = 0.0;
    sx = 0.0;
    sy = 0.0;
    for ( i = 0; i <= 10 - 1; i++) {
 q[i] = 0.0;
    }
    k_offset = -1;
    energymonitor__setfilename("ep.csv");
    energymonitor__init(cores,1);
    energymonitor__trackpoweronly();
    energymonitor__startprofiling();
        
#pragma omp parallel copyin(x)
{
    double t1, t2, t3, t4, x1, x2;
    int kk, i, ik, l;
    double qq[10];
    for (i = 0; i < 10; i++) qq[i] = 0.0;
        
#pragma omp for reduction(+:sx,sy) schedule(static)
    for (k = 1; k <= np; k++) {
 kk = k_offset + k;
 t1 = 271828183.0;
 t2 = an;
 for (i = 1; i <= 100; i++) {
            ik = kk / 2;
            if (2 * ik != kk) t3 = randlc(&t1, t2);
            if (ik == 0) break;
            t3 = randlc(&t2, t2);
            kk = ik;
 }
 vranlc(2*(1 << 16), &t1, 1220703125.0, x-1);
 for ( i = 0; i < (1 << 16); i++) {
            x1 = 2.0 * x[2*i] - 1.0;
            x2 = 2.0 * x[2*i+1] - 1.0;
            t1 = ((x1)*(x1)) + ((x2)*(x2));
            if (t1 <= 1.0) {
  t2 = sqrt(-2.0 * log(t1) / t1);
  t3 = (x1 * t2);
  t4 = (x2 * t2);
  l = (((fabs(t3)) > (fabs(t4))) ? (fabs(t3)) : (fabs(t4)));
  qq[l] += 1.0;
  sx = sx + t3;
  sy = sy + t4;
            }
 }
 if (0 == 1) timer_stop(2);
    }
        
#pragma omp critical
    {
      for (i = 0; i <= 10 - 1; i++) q[i] += qq[i];
    }
        
#pragma omp master
    {
      nthreads = omp_get_num_threads();
    }
 }
 energymonitor__stopprofiling();
    for (i = 0; i <= 10 -1; i++) {
        gc = gc + q[i];
    }
    timer_stop(1);
    tm = timer_read(1);
    nit = 0;
    if (28 == 24) {
 if((fabs((sx- (-3.247834652034740e3))/sx) <= 1.0e-8) &&
    (fabs((sy- (-6.958407078382297e3))/sy) <= 1.0e-8)) {
     verified = 1;
 }
    } else if (28 == 25) {
 if ((fabs((sx- (-2.863319731645753e3))/sx) <= 1.0e-8) &&
     (fabs((sy- (-6.320053679109499e3))/sy) <= 1.0e-8)) {
     verified = 1;
 }
    } else if (28 == 28) {
 if ((fabs((sx- (-4.295875165629892e3))/sx) <= 1.0e-8) &&
     (fabs((sy- (-1.580732573678431e4))/sy) <= 1.0e-8)) {
     verified = 1;
 }
    } else if (28 == 30) {
 if ((fabs((sx- (4.033815542441498e4))/sx) <= 1.0e-8) &&
     (fabs((sy- (-2.660669192809235e4))/sy) <= 1.0e-8)) {
     verified = 1;
 }
    } else if (28 == 32) {
 if ((fabs((sx- (4.764367927995374e4))/sx) <= 1.0e-8) &&
     (fabs((sy- (-8.084072988043731e4))/sy) <= 1.0e-8)) {
     verified = 1;
 }
    }
    Mops = pow(2.0, 28 +1)/tm/1000000.0;
    printf("EP Benchmark Results: \n"
    "CPU Time = %10.4f\n"
    "N = 2^%5d\n"
    "No. Gaussian Pairs = %15.0f\n"
    "Sums = %25.15e %25.15e\n"
    "Counts:\n",
    tm, 28, gc, sx, sy);
    for (i = 0; i <= 10 -1; i++) {
 printf("%3d %15.0f\n", i, q[i]);
    }
    c_print_results("EP", 'A', 28 +1, 0, 0, nit, nthreads,
    tm, Mops,
    "Random numbers generated",
    verified, "2.3", "10 Sep 2016",
    "gcc", "g++", "-lenergymodule", "-I../common -I../../../workspace/testmonito...", "-O3 -lm -fopenmp -lenergymodule ", "(none)", "randdp");
    if (0 == 1) {
 printf("Total time:     %f", timer_read(1));
 printf("Gaussian pairs: %f", timer_read(2));
 printf("Random numbers: %f", timer_read(3));
    }
}
