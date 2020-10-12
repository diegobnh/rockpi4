#include "mg_pre.h"
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
static int is1, is2, is3, ie1, ie2, ie3;
int cores = 255;
static void setup(int *n1, int *n2, int *n3, int lt);
static void mg3P(double ****u, double ***v, double ****r, double a[4],
   double c[4], int n1, int n2, int n3, int k);
static void psinv( double ***r, double ***u, int n1, int n2, int n3,
     double c[4], int k);
static void resid( double ***u, double ***v, double ***r,
     int n1, int n2, int n3, double a[4], int k );
static void rprj3( double ***r, int m1k, int m2k, int m3k,
     double ***s, int m1j, int m2j, int m3j, int k );
static void interp( double ***z, int mm1, int mm2, int mm3,
      double ***u, int n1, int n2, int n3, int k );
static void norm2u3(double ***r, int n1, int n2, int n3,
      double *rnm2, double *rnmu, int nx, int ny, int nz);
static void rep_nrm(double ***u, int n1, int n2, int n3,
      char *title, int kk);
static void comm3(double ***u, int n1, int n2, int n3, int kk);
static void zran3(double ***z, int n1, int n2, int n3, int nx, int ny, int k);
static void showall(double ***z, int n1, int n2, int n3);
static double power( double a, int n );
static void bubble( double ten[1037][2], int j1[1037][2], int j2[1037][2],
      int j3[1037][2], int m, int ind );
static void zero3(double ***z, int n1, int n2, int n3);
static void nonzero(double ***z, int n1, int n2, int n3);
int main(int argc, char *argv[]) {
  int k, it;
  double t, tinit, mflops;
  int nthreads = 1;
  double ****u, ***v, ****r;
  double a[4], c[4];
  double rnm2, rnmu;
  double epsilon = 1.0e-8;
  int n1, n2, n3, nit;
  double verify_value;
  boolean verified;
  int i, j, l;
  FILE *fp;
  timer_clear(1);
  timer_clear(2);
  timer_start(2);
  printf("\n\n NAS Parallel Benchmarks 2.3 OpenMP C version"
  " - MG Benchmark\n\n");
  fp = fopen("mg.input", "r");
  if (fp != ((void *)0)) {
    printf(" Reading from input file mg.input\n");
    fscanf(fp, "%d", &lt);
    while(fgetc(fp) != '\n');
    fscanf(fp, "%d%d%d", &nx[lt], &ny[lt], &nz[lt]);
    while(fgetc(fp) != '\n');
    fscanf(fp, "%d", &nit);
    while(fgetc(fp) != '\n');
    for (i = 0; i <= 7; i++) {
      fscanf(fp, "%d", &debug_vec[i]);
    }
    fclose(fp);
  } else {
    printf(" No input file. Using compiled defaults\n");
    lt = 8;
    nit = 4;
    nx[lt] = 256;
    ny[lt] = 256;
    nz[lt] = 256;
    for (i = 0; i <= 7; i++) {
      debug_vec[i] = 0;
    }
  }
  if ( (nx[lt] != ny[lt]) || (nx[lt] != nz[lt]) ) {
    Class = 'U';
  } else if( nx[lt] == 32 && nit == 4 ) {
    Class = 'S';
  } else if( nx[lt] == 64 && nit == 40 ) {
    Class = 'W';
  } else if( nx[lt] == 256 && nit == 20 ) {
    Class = 'B';
  } else if( nx[lt] == 512 && nit == 20 ) {
    Class = 'C';
  } else if( nx[lt] == 256 && nit == 4 ) {
    Class = 'A';
  } else {
    Class = 'U';
  }
  a[0] = -8.0/3.0;
  a[1] = 0.0;
  a[2] = 1.0/6.0;
  a[3] = 1.0/12.0;
  if (Class == 'A' || Class == 'S' || Class =='W') {
    c[0] = -3.0/8.0;
    c[1] = 1.0/32.0;
    c[2] = -1.0/64.0;
    c[3] = 0.0;
  } else {
    c[0] = -3.0/17.0;
    c[1] = 1.0/33.0;
    c[2] = -1.0/61.0;
    c[3] = 0.0;
  }
  lb = 1;
  setup(&n1,&n2,&n3,lt);
  u = (double ****)malloc((lt+1)*sizeof(double ***));
  for (l = lt; l >=1; l--) {
    u[l] = (double ***)malloc(m3[l]*sizeof(double **));
    for (k = 0; k < m3[l]; k++) {
      u[l][k] = (double **)malloc(m2[l]*sizeof(double *));
      for (j = 0; j < m2[l]; j++) {
 u[l][k][j] = (double *)malloc(m1[l]*sizeof(double));
      }
    }
  }
  v = (double ***)malloc(m3[lt]*sizeof(double **));
  for (k = 0; k < m3[lt]; k++) {
    v[k] = (double **)malloc(m2[lt]*sizeof(double *));
    for (j = 0; j < m2[lt]; j++) {
      v[k][j] = (double *)malloc(m1[lt]*sizeof(double));
    }
  }
  r = (double ****)malloc((lt+1)*sizeof(double ***));
  for (l = lt; l >=1; l--) {
    r[l] = (double ***)malloc(m3[l]*sizeof(double **));
    for (k = 0; k < m3[l]; k++) {
      r[l][k] = (double **)malloc(m2[l]*sizeof(double *));
      for (j = 0; j < m2[l]; j++) {
 r[l][k][j] = (double *)malloc(m1[l]*sizeof(double));
      }
    }
  }
        
#pragma omp parallel
  {
    zero3(u[lt],n1,n2,n3);
  }
  zran3(v,n1,n2,n3,nx[lt],ny[lt],lt);
        
#pragma omp parallel
  {
    norm2u3(v,n1,n2,n3,&rnm2,&rnmu,nx[lt],ny[lt],nz[lt]);
        
#pragma omp single
    {
      printf(" Size: %3dx%3dx%3d (class %1c)\n",
      nx[lt], ny[lt], nz[lt], Class);
      printf(" Iterations: %3d\n", nit);
    }
    resid(u[lt],v,r[lt],n1,n2,n3,a,lt);
    norm2u3(r[lt],n1,n2,n3,&rnm2,&rnmu,nx[lt],ny[lt],nz[lt]);
    mg3P(u,v,r,a,c,n1,n2,n3,lt);
    resid(u[lt],v,r[lt],n1,n2,n3,a,lt);
        
#pragma omp single
    setup(&n1,&n2,&n3,lt);
    zero3(u[lt],n1,n2,n3);
  }
  zran3(v,n1,n2,n3,nx[lt],ny[lt],lt);
  timer_stop(2);
  energymonitor__setfilename("mg.csv");
  energymonitor__init(cores,1);
  energymonitor__trackpoweronly();
  energymonitor__startprofiling();
  timer_start(1);
        
#pragma omp parallel firstprivate(nit) private(it)
  {
    resid(u[lt],v,r[lt],n1,n2,n3,a,lt);
    norm2u3(r[lt],n1,n2,n3,&rnm2,&rnmu,nx[lt],ny[lt],nz[lt]);
    for ( it = 1; it <= nit; it++) {
      mg3P(u,v,r,a,c,n1,n2,n3,lt);
      resid(u[lt],v,r[lt],n1,n2,n3,a,lt);
    }
    norm2u3(r[lt],n1,n2,n3,&rnm2,&rnmu,nx[lt],ny[lt],nz[lt]);
        
#pragma omp master
    nthreads = omp_get_num_threads();
  }
  timer_stop(1);
  energymonitor__stopprofiling();
  t = timer_read(1);
  tinit = timer_read(2);
  verified = 0;
  verify_value = 0.0;
  printf(" Initialization time: %15.3f seconds\n", tinit);
  printf(" Benchmark completed\n");
  if (Class != 'U') {
    if (Class == 'S') {
      verify_value = 0.530770700573e-04;
    } else if (Class == 'W') {
      verify_value = 0.250391406439e-17;
    } else if (Class == 'A') {
      verify_value = 0.2433365309e-5;
    } else if (Class == 'B') {
      verify_value = 0.180056440132e-5;
    } else if (Class == 'C') {
      verify_value = 0.570674826298e-06;
    }
    if ( fabs( rnm2 - verify_value ) <= epsilon ) {
      verified = 1;
      printf(" VERIFICATION SUCCESSFUL\n");
      printf(" L2 Norm is %20.12e\n", rnm2);
      printf(" Error is   %20.12e\n", rnm2 - verify_value);
    } else {
      verified = 0;
      printf(" VERIFICATION FAILED\n");
      printf(" L2 Norm is             %20.12e\n", rnm2);
      printf(" The correct L2 Norm is %20.12e\n", verify_value);
    }
  } else {
    verified = 0;
    printf(" Problem size unknown\n");
    printf(" NO VERIFICATION PERFORMED\n");
  }
  if ( t != 0.0 ) {
    int nn = nx[lt]*ny[lt]*nz[lt];
    mflops = 58.*nit*nn*1.0e-6 / t;
  } else {
    mflops = 0.0;
  }
  c_print_results("MG", Class, nx[lt], ny[lt], nz[lt],
    nit, nthreads, t, mflops, "          floating point",
    verified, "2.3", "10 Sep 2016",
    "gcc", "g++", "-lenergymodule", "-I../common -I../../../workspace/testmonito...", "-O3 -lm -fopenmp -lenergymodule ", "(none)", "randdp");
}
static void setup(int *n1, int *n2, int *n3, int lt) {
  int k;
  for ( k = lt-1; k >= 1; k--) {
    nx[k] = nx[k+1]/2;
    ny[k] = ny[k+1]/2;
    nz[k] = nz[k+1]/2;
  }
  for (k = 1; k <= lt; k++) {
    m1[k] = nx[k]+2;
    m2[k] = nz[k]+2;
    m3[k] = ny[k]+2;
  }
  is1 = 1;
  ie1 = nx[lt];
  *n1 = nx[lt]+2;
  is2 = 1;
  ie2 = ny[lt];
  *n2 = ny[lt]+2;
  is3 = 1;
  ie3 = nz[lt];
  *n3 = nz[lt]+2;
  if (debug_vec[1] >= 1 ) {
    printf(" in setup, \n");
    printf("  lt  nx  ny  nz  n1  n2  n3 is1 is2 is3 ie1 ie2 ie3\n");
    printf("%4d%4d%4d%4d%4d%4d%4d%4d%4d%4d%4d%4d%4d\n",
    lt,nx[lt],ny[lt],nz[lt],*n1,*n2,*n3,is1,is2,is3,ie1,ie2,ie3);
  }
}
static void mg3P(double ****u, double ***v, double ****r, double a[4],
   double c[4], int n1, int n2, int n3, int k) {
  int j;
  for (k = lt; k >= lb+1; k--) {
    j = k-1;
    rprj3(r[k], m1[k], m2[k], m3[k],
   r[j], m1[j], m2[j], m3[j], k);
  }
  k = lb;
  zero3(u[k], m1[k], m2[k], m3[k]);
  psinv(r[k], u[k], m1[k], m2[k], m3[k], c, k);
  for (k = lb+1; k <= lt-1; k++) {
    j = k-1;
    zero3(u[k], m1[k], m2[k], m3[k]);
    interp(u[j], m1[j], m2[j], m3[j],
    u[k], m1[k], m2[k], m3[k], k);
    resid(u[k], r[k], r[k], m1[k], m2[k], m3[k], a, k);
    psinv(r[k], u[k], m1[k], m2[k], m3[k], c, k);
  }
  j = lt - 1;
  k = lt;
  interp(u[j], m1[j], m2[j], m3[j], u[lt], n1, n2, n3, k);
  resid(u[lt], v, r[lt], n1, n2, n3, a, k);
  psinv(r[lt], u[lt], n1, n2, n3, c, k);
}
static void psinv( double ***r, double ***u, int n1, int n2, int n3,
     double c[4], int k) {
  int i3, i2, i1;
  double r1[1037], r2[1037];
        
#pragma omp for
  for (i3 = 1; i3 < n3-1; i3++) {
    for (i2 = 1; i2 < n2-1; i2++) {
      for (i1 = 0; i1 < n1; i1++) {
 r1[i1] = r[i3][i2-1][i1] + r[i3][i2+1][i1]
   + r[i3-1][i2][i1] + r[i3+1][i2][i1];
 r2[i1] = r[i3-1][i2-1][i1] + r[i3-1][i2+1][i1]
   + r[i3+1][i2-1][i1] + r[i3+1][i2+1][i1];
      }
      for (i1 = 1; i1 < n1-1; i1++) {
 u[i3][i2][i1] = u[i3][i2][i1]
   + c[0] * r[i3][i2][i1]
   + c[1] * ( r[i3][i2][i1-1] + r[i3][i2][i1+1]
       + r1[i1] )
   + c[2] * ( r2[i1] + r1[i1-1] + r1[i1+1] );
      }
    }
  }
  comm3(u,n1,n2,n3,k);
  if (debug_vec[0] >= 1 ) {
        
#pragma omp single
    rep_nrm(u,n1,n2,n3,"   psinv",k);
  }
  if ( debug_vec[3] >= k ) {
        
#pragma omp single
    showall(u,n1,n2,n3);
  }
}
static void resid( double ***u, double ***v, double ***r,
     int n1, int n2, int n3, double a[4], int k ) {
  int i3, i2, i1;
  double u1[1037], u2[1037];
        
#pragma omp for
  for (i3 = 1; i3 < n3-1; i3++) {
    for (i2 = 1; i2 < n2-1; i2++) {
      for (i1 = 0; i1 < n1; i1++) {
 u1[i1] = u[i3][i2-1][i1] + u[i3][i2+1][i1]
   + u[i3-1][i2][i1] + u[i3+1][i2][i1];
 u2[i1] = u[i3-1][i2-1][i1] + u[i3-1][i2+1][i1]
   + u[i3+1][i2-1][i1] + u[i3+1][i2+1][i1];
      }
      for (i1 = 1; i1 < n1-1; i1++) {
 r[i3][i2][i1] = v[i3][i2][i1]
   - a[0] * u[i3][i2][i1]
   - a[2] * ( u2[i1] + u1[i1-1] + u1[i1+1] )
   - a[3] * ( u2[i1-1] + u2[i1+1] );
      }
    }
  }
  comm3(r,n1,n2,n3,k);
  if (debug_vec[0] >= 1 ) {
        
#pragma omp single
    rep_nrm(r,n1,n2,n3,"   resid",k);
  }
  if ( debug_vec[2] >= k ) {
        
#pragma omp single
    showall(r,n1,n2,n3);
  }
}
static void rprj3( double ***r, int m1k, int m2k, int m3k,
     double ***s, int m1j, int m2j, int m3j, int k ) {
  int j3, j2, j1, i3, i2, i1, d1, d2, d3;
  double x1[1037], y1[1037], x2, y2;
  if (m1k == 3) {
    d1 = 2;
  } else {
    d1 = 1;
  }
  if (m2k == 3) {
    d2 = 2;
  } else {
    d2 = 1;
  }
  if (m3k == 3) {
    d3 = 2;
  } else {
    d3 = 1;
  }
        
#pragma omp for
  for (j3 = 1; j3 < m3j-1; j3++) {
    i3 = 2*j3-d3;
    for (j2 = 1; j2 < m2j-1; j2++) {
      i2 = 2*j2-d2;
      for (j1 = 1; j1 < m1j; j1++) {
 i1 = 2*j1-d1;
 x1[i1] = r[i3+1][i2][i1] + r[i3+1][i2+2][i1]
   + r[i3][i2+1][i1] + r[i3+2][i2+1][i1];
 y1[i1] = r[i3][i2][i1] + r[i3+2][i2][i1]
   + r[i3][i2+2][i1] + r[i3+2][i2+2][i1];
      }
      for (j1 = 1; j1 < m1j-1; j1++) {
 i1 = 2*j1-d1;
 y2 = r[i3][i2][i1+1] + r[i3+2][i2][i1+1]
   + r[i3][i2+2][i1+1] + r[i3+2][i2+2][i1+1];
 x2 = r[i3+1][i2][i1+1] + r[i3+1][i2+2][i1+1]
   + r[i3][i2+1][i1+1] + r[i3+2][i2+1][i1+1];
 s[j3][j2][j1] =
   0.5 * r[i3+1][i2+1][i1+1]
   + 0.25 * ( r[i3+1][i2+1][i1] + r[i3+1][i2+1][i1+2] + x2)
   + 0.125 * ( x1[i1] + x1[i1+2] + y2)
   + 0.0625 * ( y1[i1] + y1[i1+2] );
      }
    }
  }
  comm3(s,m1j,m2j,m3j,k-1);
  if (debug_vec[0] >= 1 ) {
        
#pragma omp single
    rep_nrm(s,m1j,m2j,m3j,"   rprj3",k-1);
  }
  if (debug_vec[4] >= k ) {
        
#pragma omp single
    showall(s,m1j,m2j,m3j);
  }
}
static void interp( double ***z, int mm1, int mm2, int mm3,
      double ***u, int n1, int n2, int n3, int k ) {
  int i3, i2, i1, d1, d2, d3, t1, t2, t3;
  double z1[1037], z2[1037], z3[1037];
  if ( n1 != 3 && n2 != 3 && n3 != 3 ) {
        
#pragma omp for
    for (i3 = 0; i3 < mm3-1; i3++) {
      for (i2 = 0; i2 < mm2-1; i2++) {
 for (i1 = 0; i1 < mm1; i1++) {
   z1[i1] = z[i3][i2+1][i1] + z[i3][i2][i1];
   z2[i1] = z[i3+1][i2][i1] + z[i3][i2][i1];
   z3[i1] = z[i3+1][i2+1][i1] + z[i3+1][i2][i1] + z1[i1];
 }
 for (i1 = 0; i1 < mm1-1; i1++) {
   u[2*i3][2*i2][2*i1] = u[2*i3][2*i2][2*i1]
     +z[i3][i2][i1];
   u[2*i3][2*i2][2*i1+1] = u[2*i3][2*i2][2*i1+1]
     +0.5*(z[i3][i2][i1+1]+z[i3][i2][i1]);
 }
 for (i1 = 0; i1 < mm1-1; i1++) {
   u[2*i3][2*i2+1][2*i1] = u[2*i3][2*i2+1][2*i1]
     +0.5 * z1[i1];
   u[2*i3][2*i2+1][2*i1+1] = u[2*i3][2*i2+1][2*i1+1]
     +0.25*( z1[i1] + z1[i1+1] );
 }
 for (i1 = 0; i1 < mm1-1; i1++) {
   u[2*i3+1][2*i2][2*i1] = u[2*i3+1][2*i2][2*i1]
     +0.5 * z2[i1];
   u[2*i3+1][2*i2][2*i1+1] = u[2*i3+1][2*i2][2*i1+1]
     +0.25*( z2[i1] + z2[i1+1] );
 }
 for (i1 = 0; i1 < mm1-1; i1++) {
   u[2*i3+1][2*i2+1][2*i1] = u[2*i3+1][2*i2+1][2*i1]
     +0.25* z3[i1];
   u[2*i3+1][2*i2+1][2*i1+1] = u[2*i3+1][2*i2+1][2*i1+1]
     +0.125*( z3[i1] + z3[i1+1] );
 }
      }
    }
  } else {
    if (n1 == 3) {
      d1 = 2;
      t1 = 1;
    } else {
      d1 = 1;
      t1 = 0;
    }
    if (n2 == 3) {
      d2 = 2;
      t2 = 1;
    } else {
      d2 = 1;
      t2 = 0;
    }
    if (n3 == 3) {
      d3 = 2;
      t3 = 1;
    } else {
      d3 = 1;
      t3 = 0;
    }
        
#pragma omp for
    for ( i3 = d3; i3 <= mm3-1; i3++) {
      for ( i2 = d2; i2 <= mm2-1; i2++) {
 for ( i1 = d1; i1 <= mm1-1; i1++) {
   u[2*i3-d3-1][2*i2-d2-1][2*i1-d1-1] =
     u[2*i3-d3-1][2*i2-d2-1][2*i1-d1-1]
     +z[i3-1][i2-1][i1-1];
 }
 for ( i1 = 1; i1 <= mm1-1; i1++) {
   u[2*i3-d3-1][2*i2-d2-1][2*i1-t1-1] =
     u[2*i3-d3-1][2*i2-d2-1][2*i1-t1-1]
     +0.5*(z[i3-1][i2-1][i1]+z[i3-1][i2-1][i1-1]);
 }
      }
      for ( i2 = 1; i2 <= mm2-1; i2++) {
 for ( i1 = d1; i1 <= mm1-1; i1++) {
   u[2*i3-d3-1][2*i2-t2-1][2*i1-d1-1] =
     u[2*i3-d3-1][2*i2-t2-1][2*i1-d1-1]
     +0.5*(z[i3-1][i2][i1-1]+z[i3-1][i2-1][i1-1]);
 }
 for ( i1 = 1; i1 <= mm1-1; i1++) {
   u[2*i3-d3-1][2*i2-t2-1][2*i1-t1-1] =
     u[2*i3-d3-1][2*i2-t2-1][2*i1-t1-1]
     +0.25*(z[i3-1][i2][i1]+z[i3-1][i2-1][i1]
     +z[i3-1][i2][i1-1]+z[i3-1][i2-1][i1-1]);
 }
      }
    }
        
#pragma omp for
    for ( i3 = 1; i3 <= mm3-1; i3++) {
      for ( i2 = d2; i2 <= mm2-1; i2++) {
 for ( i1 = d1; i1 <= mm1-1; i1++) {
   u[2*i3-t3-1][2*i2-d2-1][2*i1-d1-1] =
     u[2*i3-t3-1][2*i2-d2-1][2*i1-d1-1]
     +0.5*(z[i3][i2-1][i1-1]+z[i3-1][i2-1][i1-1]);
 }
 for ( i1 = 1; i1 <= mm1-1; i1++) {
   u[2*i3-t3-1][2*i2-d2-1][2*i1-t1-1] =
     u[2*i3-t3-1][2*i2-d2-1][2*i1-t1-1]
     +0.25*(z[i3][i2-1][i1]+z[i3][i2-1][i1-1]
     +z[i3-1][i2-1][i1]+z[i3-1][i2-1][i1-1]);
 }
      }
      for ( i2 = 1; i2 <= mm2-1; i2++) {
 for ( i1 = d1; i1 <= mm1-1; i1++) {
   u[2*i3-t3-1][2*i2-t2-1][2*i1-d1-1] =
     u[2*i3-t3-1][2*i2-t2-1][2*i1-d1-1]
     +0.25*(z[i3][i2][i1-1]+z[i3][i2-1][i1-1]
     +z[i3-1][i2][i1-1]+z[i3-1][i2-1][i1-1]);
 }
 for ( i1 = 1; i1 <= mm1-1; i1++) {
   u[2*i3-t3-1][2*i2-t2-1][2*i1-t1-1] =
     u[2*i3-t3-1][2*i2-t2-1][2*i1-t1-1]
     +0.125*(z[i3][i2][i1]+z[i3][i2-1][i1]
      +z[i3][i2][i1-1]+z[i3][i2-1][i1-1]
      +z[i3-1][i2][i1]+z[i3-1][i2-1][i1]
      +z[i3-1][i2][i1-1]+z[i3-1][i2-1][i1-1]);
 }
      }
    }
  }
        
#pragma omp single
  {
    if (debug_vec[0] >= 1 ) {
      rep_nrm(z,mm1,mm2,mm3,"z: inter",k-1);
      rep_nrm(u,n1,n2,n3,"u: inter",k);
    }
    if ( debug_vec[5] >= k ) {
      showall(z,mm1,mm2,mm3);
      showall(u,n1,n2,n3);
    }
  }
}
static void norm2u3(double ***r, int n1, int n2, int n3,
      double *rnm2, double *rnmu, int nx, int ny, int nz) {
  static double s = 0.0;
  double tmp;
  int i3, i2, i1, n;
  double p_s = 0.0, p_a = 0.0;
  n = nx*ny*nz;
        
#pragma omp for
  for (i3 = 1; i3 < n3-1; i3++) {
    for (i2 = 1; i2 < n2-1; i2++) {
      for (i1 = 1; i1 < n1-1; i1++) {
 p_s = p_s + r[i3][i2][i1] * r[i3][i2][i1];
 tmp = fabs(r[i3][i2][i1]);
 if (tmp > p_a) p_a = tmp;
      }
    }
  }
        
#pragma omp critical
  {
    s += p_s;
    if (p_a > *rnmu) *rnmu = p_a;
  }
        
#pragma omp barrier
        
#pragma omp single
  {
    *rnm2 = sqrt(s/(double)n);
    s = 0.0;
  }
}
static void rep_nrm(double ***u, int n1, int n2, int n3,
      char *title, int kk) {
  double rnm2, rnmu;
  norm2u3(u,n1,n2,n3,&rnm2,&rnmu,nx[kk],ny[kk],nz[kk]);
  printf(" Level%2d in %8s: norms =%21.14e%21.14e\n",
  kk, title, rnm2, rnmu);
}
static void comm3(double ***u, int n1, int n2, int n3, int kk) {
  int i1, i2, i3;
        
#pragma omp for
  for ( i3 = 1; i3 < n3-1; i3++) {
    for ( i2 = 1; i2 < n2-1; i2++) {
      u[i3][i2][n1-1] = u[i3][i2][1];
      u[i3][i2][0] = u[i3][i2][n1-2];
    }
  }
        
#pragma omp for
  for ( i3 = 1; i3 < n3-1; i3++) {
    for ( i1 = 0; i1 < n1; i1++) {
      u[i3][n2-1][i1] = u[i3][1][i1];
      u[i3][0][i1] = u[i3][n2-2][i1];
    }
  }
        
#pragma omp for
  for ( i2 = 0; i2 < n2; i2++) {
    for ( i1 = 0; i1 < n1; i1++) {
      u[n3-1][i2][i1] = u[1][i2][i1];
      u[0][i2][i1] = u[n3-2][i2][i1];
    }
  }
}
static void zran3(double ***z, int n1, int n2, int n3, int nx, int ny, int k) {
  int i0, m0, m1;
  int i1, i2, i3, d1, e1, e2, e3;
  double xx, x0, x1, a1, a2, ai;
  double ten[10][2], best;
  int i, j1[10][2], j2[10][2], j3[10][2];
  int jg[4][10][2];
  double rdummy;
  a1 = power( pow(5.0,13), nx );
  a2 = power( pow(5.0,13), nx*ny );
        
#pragma omp parallel
  {
    zero3(z,n1,n2,n3);
  }
  i = is1-1+nx*(is2-1+ny*(is3-1));
  ai = power( pow(5.0,13), i );
  d1 = ie1 - is1 + 1;
  e1 = ie1 - is1 + 2;
  e2 = ie2 - is2 + 2;
  e3 = ie3 - is3 + 2;
  x0 = 314159265.e0;
  rdummy = randlc( &x0, ai );
  for (i3 = 1; i3 < e3; i3++) {
    x1 = x0;
    for (i2 = 1; i2 < e2; i2++) {
      xx = x1;
      vranlc( d1, &xx, pow(5.0,13), &(z[i3][i2][0]));
      rdummy = randlc( &x1, a1 );
    }
    rdummy = randlc( &x0, a2 );
  }
  for (i = 0; i < 10; i++) {
    ten[i][1] = 0.0;
    j1[i][1] = 0;
    j2[i][1] = 0;
    j3[i][1] = 0;
    ten[i][0] = 1.0;
    j1[i][0] = 0;
    j2[i][0] = 0;
    j3[i][0] = 0;
  }
  for (i3 = 1; i3 < n3-1; i3++) {
    for (i2 = 1; i2 < n2-1; i2++) {
      for (i1 = 1; i1 < n1-1; i1++) {
 if ( z[i3][i2][i1] > ten[0][1] ) {
   ten[0][1] = z[i3][i2][i1];
   j1[0][1] = i1;
   j2[0][1] = i2;
   j3[0][1] = i3;
   bubble( ten, j1, j2, j3, 10, 1 );
 }
 if ( z[i3][i2][i1] < ten[0][0] ) {
   ten[0][0] = z[i3][i2][i1];
   j1[0][0] = i1;
   j2[0][0] = i2;
   j3[0][0] = i3;
   bubble( ten, j1, j2, j3, 10, 0 );
 }
      }
    }
  }
  i1 = 10 - 1;
  i0 = 10 - 1;
  for (i = 10 - 1 ; i >= 0; i--) {
    best = z[j3[i1][1]][j2[i1][1]][j1[i1][1]];
    if (best == z[j3[i1][1]][j2[i1][1]][j1[i1][1]]) {
      jg[0][i][1] = 0;
      jg[1][i][1] = is1 - 1 + j1[i1][1];
      jg[2][i][1] = is2 - 1 + j2[i1][1];
      jg[3][i][1] = is3 - 1 + j3[i1][1];
      i1 = i1-1;
    } else {
      jg[0][i][1] = 0;
      jg[1][i][1] = 0;
      jg[2][i][1] = 0;
      jg[3][i][1] = 0;
    }
    ten[i][1] = best;
    best = z[j3[i0][0]][j2[i0][0]][j1[i0][0]];
    if (best == z[j3[i0][0]][j2[i0][0]][j1[i0][0]]) {
      jg[0][i][0] = 0;
      jg[1][i][0] = is1 - 1 + j1[i0][0];
      jg[2][i][0] = is2 - 1 + j2[i0][0];
      jg[3][i][0] = is3 - 1 + j3[i0][0];
      i0 = i0-1;
    } else {
      jg[0][i][0] = 0;
      jg[1][i][0] = 0;
      jg[2][i][0] = 0;
      jg[3][i][0] = 0;
    }
    ten[i][0] = best;
  }
  m1 = i1+1;
  m0 = i0+1;
        
#pragma omp parallel for private(i2, i1)
  for (i3 = 0; i3 < n3; i3++) {
    for (i2 = 0; i2 < n2; i2++) {
      for (i1 = 0; i1 < n1; i1++) {
 z[i3][i2][i1] = 0.0;
      }
    }
  }
  for (i = 10 -1; i >= m0; i--) {
    z[j3[i][0]][j2[i][0]][j1[i][0]] = -1.0;
  }
  for (i = 10 -1; i >= m1; i--) {
    z[j3[i][1]][j2[i][1]][j1[i][1]] = 1.0;
  }
        
#pragma omp parallel
  comm3(z,n1,n2,n3,k);
}
static void showall(double ***z, int n1, int n2, int n3) {
  int i1,i2,i3;
  int m1, m2, m3;
  m1 = (((n1) < (18)) ? (n1) : (18));
  m2 = (((n2) < (14)) ? (n2) : (14));
  m3 = (((n3) < (18)) ? (n3) : (18));
  printf("\n");
  for (i3 = 0; i3 < m3; i3++) {
    for (i1 = 0; i1 < m1; i1++) {
      for (i2 = 0; i2 < m2; i2++) {
 printf("%6.3f", z[i3][i2][i1]);
      }
      printf("\n");
    }
    printf(" - - - - - - - \n");
  }
  printf("\n");
}
static double power( double a, int n ) {
  double aj;
  int nj;
  double rdummy;
  double power;
  power = 1.0;
  aj = a;
  nj = n;
  while (nj != 0) {
    if( (nj%2) == 1 ) rdummy = randlc( &power, aj );
    rdummy = randlc( &aj, aj );
    nj = nj/2;
  }
  return (power);
}
static void bubble( double ten[1037][2], int j1[1037][2], int j2[1037][2],
      int j3[1037][2], int m, int ind ) {
  double temp;
  int i, j_temp;
  if ( ind == 1 ) {
    for (i = 0; i < m-1; i++) {
      if ( ten[i][ind] > ten[i+1][ind] ) {
 temp = ten[i+1][ind];
 ten[i+1][ind] = ten[i][ind];
 ten[i][ind] = temp;
 j_temp = j1[i+1][ind];
 j1[i+1][ind] = j1[i][ind];
 j1[i][ind] = j_temp;
 j_temp = j2[i+1][ind];
 j2[i+1][ind] = j2[i][ind];
 j2[i][ind] = j_temp;
 j_temp = j3[i+1][ind];
 j3[i+1][ind] = j3[i][ind];
 j3[i][ind] = j_temp;
      } else {
 return;
      }
    }
  } else {
    for (i = 0; i < m-1; i++) {
      if ( ten[i][ind] < ten[i+1][ind] ) {
 temp = ten[i+1][ind];
 ten[i+1][ind] = ten[i][ind];
 ten[i][ind] = temp;
 j_temp = j1[i+1][ind];
 j1[i+1][ind] = j1[i][ind];
 j1[i][ind] = j_temp;
 j_temp = j2[i+1][ind];
 j2[i+1][ind] = j2[i][ind];
 j2[i][ind] = j_temp;
 j_temp = j3[i+1][ind];
 j3[i+1][ind] = j3[i][ind];
 j3[i][ind] = j_temp;
      } else {
 return;
      }
    }
  }
}
static void zero3(double ***z, int n1, int n2, int n3) {
  int i1, i2, i3;
        
#pragma omp for
  for (i3 = 0;i3 < n3; i3++) {
    for (i2 = 0; i2 < n2; i2++) {
      for (i1 = 0; i1 < n1; i1++) {
 z[i3][i2][i1] = 0.0;
      }
    }
  }
}
