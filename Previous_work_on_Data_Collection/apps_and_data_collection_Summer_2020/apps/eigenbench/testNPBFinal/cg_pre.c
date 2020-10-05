#include "cg_pre.h"
typedef int boolean;
int cores = 255;
static int naa;
static int nzz;
static int firstrow;
static int lastrow;
static int firstcol;
static int lastcol;
static int colidx[14000*(11 +1)*(11 +1)+14000*(11 +2)+1];
static int rowstr[14000 +1+1];
static int iv[2*14000 +1+1];
static int arow[14000*(11 +1)*(11 +1)+14000*(11 +2)+1];
static int acol[14000*(11 +1)*(11 +1)+14000*(11 +2)+1];
static double v[14000 +1+1];
static double aelt[14000*(11 +1)*(11 +1)+14000*(11 +2)+1];
static double a[14000*(11 +1)*(11 +1)+14000*(11 +2)+1];
static double x[14000 +2+1];
static double z[14000 +2+1];
static double p[14000 +2+1];
static double q[14000 +2+1];
static double r[14000 +2+1];
static double w[14000 +2+1];
static double amult;
static double tran;
static void conj_grad (int colidx[], int rowstr[], double x[], double z[],
         double a[], double p[], double q[], double r[],
         double w[], double *rnorm);
static void makea(int n, int nz, double a[], int colidx[], int rowstr[],
    int nonzer, int firstrow, int lastrow, int firstcol,
    int lastcol, double rcond, int arow[], int acol[],
    double aelt[], double v[], int iv[], double shift );
static void sparse(double a[], int colidx[], int rowstr[], int n,
     int arow[], int acol[], double aelt[],
     int firstrow, int lastrow,
     double x[], boolean mark[], int nzloc[], int nnza);
static void sprnvc(int n, int nz, double v[], int iv[], int nzloc[],
     int mark[]);
static int icnvrt(double x, int ipwr2);
static void vecset(int n, double v[], int iv[], int *nzv, int i, double val);
int main(int argc, char **argv) {
  int i, j, k, it;
  int nthreads = 1;
  double zeta;
  double rnorm;
  double norm_temp11;
  double norm_temp12;
  double t, mflops;
  char class;
  boolean verified;
  double zeta_verify_value, epsilon;
  firstrow = 1;
  lastrow = 14000;
  firstcol = 1;
  lastcol = 14000;
  if (14000 == 1400 && 11 == 7 && 15 == 15 && 20.0 == 10.0) {
    class = 'S';
    zeta_verify_value = 8.5971775078648;
  } else if (14000 == 7000 && 11 == 8 && 15 == 15 && 20.0 == 12.0) {
    class = 'W';
    zeta_verify_value = 10.362595087124;
  } else if (14000 == 14000 && 11 == 11 && 15 == 15 && 20.0 == 20.0) {
    class = 'A';
    zeta_verify_value = 17.130235054029;
  } else if (14000 == 75000 && 11 == 13 && 15 == 75 && 20.0 == 60.0) {
    class = 'B';
    zeta_verify_value = 22.712745482631;
  } else if (14000 == 150000 && 11 == 15 && 15 == 75 && 20.0 == 110.0) {
    class = 'C';
    zeta_verify_value = 28.973605592845;
  } else {
    class = 'U';
  }
  printf("\n\n NAS Parallel Benchmarks 2.3 OpenMP C version"
  " - CG Benchmark\n");
  printf(" Size: %10d\n", 14000);
  printf(" Iterations: %5d\n", 15);
  naa = 14000;
  nzz = 14000*(11 +1)*(11 +1)+14000*(11 +2);
  tran = 314159265.0;
  amult = 1220703125.0;
  zeta = randlc( &tran, amult );
  makea(naa, nzz, a, colidx, rowstr, 11,
 firstrow, lastrow, firstcol, lastcol,
 1.0e-1, arow, acol, aelt, v, iv, 20.0);
        
#pragma omp parallel private(it,i,j,k)
  {
        
#pragma omp for nowait
    for (j = 1; j <= lastrow - firstrow + 1; j++) {
      for (k = rowstr[j]; k < rowstr[j+1]; k++) {
 colidx[k] = colidx[k] - firstcol + 1;
 }
      }
        
#pragma omp for nowait
    for (i = 1; i <= 14000 +1; i++) {
      x[i] = 1.0;
    }
        
#pragma omp single
    zeta = 0.0;
    for (it = 1; it <= 1; it++) {
      conj_grad (colidx, rowstr, x, z, a, p, q, r, w, &rnorm);
        
#pragma omp single
      {
 norm_temp11 = 0.0;
 norm_temp12 = 0.0;
      }
        
#pragma omp for reduction(+:norm_temp11,norm_temp12)
      for (j = 1; j <= lastcol-firstcol+1; j++) {
 norm_temp11 = norm_temp11 + x[j]*z[j];
 norm_temp12 = norm_temp12 + z[j]*z[j];
      }
        
#pragma omp single
      norm_temp12 = 1.0 / sqrt( norm_temp12 );
        
#pragma omp for
      for (j = 1; j <= lastcol-firstcol+1; j++) {
 x[j] = norm_temp12*z[j];
      }
    }
        
#pragma omp for nowait
    for (i = 1; i <= 14000 +1; i++) {
      x[i] = 1.0;
    }
        
#pragma omp single
    zeta = 0.0;
  }
  timer_clear( 1 );
  timer_start( 1 );
  energymonitor__setfilename("cg.csv");
  energymonitor__init(cores,1);
  energymonitor__trackpoweronly();
  energymonitor__startprofiling();
        
#pragma omp parallel private(it,i,j,k)
  {
    for (it = 1; it <= 15; it++) {
      conj_grad(colidx, rowstr, x, z, a, p, q, r, w, &rnorm);
        
#pragma omp single
      {
 norm_temp11 = 0.0;
 norm_temp12 = 0.0;
      }
        
#pragma omp for reduction(+:norm_temp11,norm_temp12)
      for (j = 1; j <= lastcol-firstcol+1; j++) {
 norm_temp11 = norm_temp11 + x[j]*z[j];
 norm_temp12 = norm_temp12 + z[j]*z[j];
      }
        
#pragma omp single
      {
 norm_temp12 = 1.0 / sqrt( norm_temp12 );
 zeta = 20.0 + 1.0 / norm_temp11;
      }
        
#pragma omp master
      {
 if( it == 1 ) {
   printf("   iteration           ||r||                 zeta\n");
 }
 printf("    %5d       %20.14e%20.13e\n", it, rnorm, zeta);
      }
        
#pragma omp for
      for (j = 1; j <= lastcol-firstcol+1; j++) {
 x[j] = norm_temp12*z[j];
      }
    }
        
#pragma omp master
    nthreads = omp_get_num_threads();
  }
  timer_stop( 1 );
  energymonitor__stopprofiling();
  t = timer_read( 1 );
  printf(" Benchmark completed\n");
  epsilon = 1.0e-10;
  if (class != 'U') {
    if (fabs(zeta - zeta_verify_value) <= epsilon) {
      verified = 1;
      printf(" VERIFICATION SUCCESSFUL\n");
      printf(" Zeta is    %20.12e\n", zeta);
      printf(" Error is   %20.12e\n", zeta - zeta_verify_value);
    } else {
      verified = 0;
      printf(" VERIFICATION FAILED\n");
      printf(" Zeta                %20.12e\n", zeta);
      printf(" The correct zeta is %20.12e\n", zeta_verify_value);
    }
  } else {
    verified = 0;
    printf(" Problem size unknown\n");
    printf(" NO VERIFICATION PERFORMED\n");
  }
  if ( t != 0.0 ) {
    mflops = (2.0*15*14000)
      * (3.0+(11*(11 +1)) + 25.0*(5.0+(11*(11 +1))) + 3.0 )
      / t / 1000000.0;
  } else {
    mflops = 0.0;
  }
  c_print_results("CG", class, 14000, 0, 0, 15, nthreads, t,
    mflops, "          floating point",
    verified, "2.3", "10 Sep 2016",
    "gcc", "g++", "-lenergymodule", "-I../common -I../../../workspace/testmonito...", "-O3 -lm -fopenmp -lenergymodule ", "(none)", "randdp");
}
static void conj_grad (
         int colidx[],
         int rowstr[],
         double x[],
         double z[],
         double a[],
         double p[],
         double q[],
         double r[],
         double w[],
         double *rnorm )
{
  static double d, sum, rho, rho0, alpha, beta;
  int i, j, k;
  int cgit, cgitmax = 25;
        
#pragma omp single nowait
  rho = 0.0;
        
#pragma omp for nowait
  for (j = 1; j <= naa+1; j++) {
    q[j] = 0.0;
    z[j] = 0.0;
    r[j] = x[j];
    p[j] = r[j];
    w[j] = 0.0;
  }
        
#pragma omp for reduction(+:rho)
  for (j = 1; j <= lastcol-firstcol+1; j++) {
    rho = rho + x[j]*x[j];
  }
  for (cgit = 1; cgit <= cgitmax; cgit++) {
        
#pragma omp single nowait
    {
      rho0 = rho;
      d = 0.0;
      rho = 0.0;
    }
        
#pragma omp for private(sum,k)
    for (j = 1; j <= lastrow-firstrow+1; j++) {
      sum = 0.0;
      for (k = rowstr[j]; k < rowstr[j+1]; k++) {
 sum = sum + a[k]*p[colidx[k]];
      }
      w[j] = sum;
    }
        
#pragma omp for
    for (j = 1; j <= lastcol-firstcol+1; j++) {
      q[j] = w[j];
    }
        
#pragma omp for nowait
    for (j = 1; j <= lastcol-firstcol+1; j++) {
      w[j] = 0.0;
    }
        
#pragma omp for reduction(+:d)
    for (j = 1; j <= lastcol-firstcol+1; j++) {
      d = d + p[j]*q[j];
    }
        
#pragma omp single
    alpha = rho0 / d;
        
#pragma omp for
    for (j = 1; j <= lastcol-firstcol+1; j++) {
      z[j] = z[j] + alpha*p[j];
      r[j] = r[j] - alpha*q[j];
    }
        
#pragma omp for reduction(+:rho)
    for (j = 1; j <= lastcol-firstcol+1; j++) {
      rho = rho + r[j]*r[j];
    }
        
#pragma omp single
    beta = rho / rho0;
        
#pragma omp for
    for (j = 1; j <= lastcol-firstcol+1; j++) {
      p[j] = r[j] + beta*p[j];
    }
  }
        
#pragma omp single nowait
  sum = 0.0;
        
#pragma omp for private(d, k)
  for (j = 1; j <= lastrow-firstrow+1; j++) {
    d = 0.0;
    for (k = rowstr[j]; k <= rowstr[j+1]-1; k++) {
      d = d + a[k]*z[colidx[k]];
    }
    w[j] = d;
  }
        
#pragma omp for
  for (j = 1; j <= lastcol-firstcol+1; j++) {
    r[j] = w[j];
  }
        
#pragma omp for reduction(+:sum) private(d)
  for (j = 1; j <= lastcol-firstcol+1; j++) {
    d = x[j] - r[j];
    sum = sum + d*d;
  }
        
#pragma omp single
  {
    (*rnorm) = sqrt(sum);
  }
}
static void makea(
    int n,
    int nz,
    double a[],
    int colidx[],
    int rowstr[],
    int nonzer,
    int firstrow,
    int lastrow,
    int firstcol,
    int lastcol,
    double rcond,
    int arow[],
    int acol[],
    double aelt[],
    double v[],
    int iv[],
    double shift )
{
  int i, nnza, iouter, ivelt, ivelt1, irow, nzv;
  double size, ratio, scale;
  int jcol;
  size = 1.0;
  ratio = pow(rcond, (1.0 / (double)n));
  nnza = 0;
        
#pragma omp parallel for
  for (i = 1; i <= n; i++) {
    colidx[n+i] = 0;
  }
  for (iouter = 1; iouter <= n; iouter++) {
    nzv = nonzer;
    sprnvc(n, nzv, v, iv, &(colidx[0]), &(colidx[n]));
    vecset(n, v, iv, &nzv, iouter, 0.5);
    for (ivelt = 1; ivelt <= nzv; ivelt++) {
      jcol = iv[ivelt];
      if (jcol >= firstcol && jcol <= lastcol) {
 scale = size * v[ivelt];
 for (ivelt1 = 1; ivelt1 <= nzv; ivelt1++) {
   irow = iv[ivelt1];
   if (irow >= firstrow && irow <= lastrow) {
     nnza = nnza + 1;
     if (nnza > nz) {
       printf("Space for matrix elements exceeded in"
       " makea\n");
       printf("nnza, nzmax = %d, %d\n", nnza, nz);
       printf("iouter = %d\n", iouter);
       exit(1);
     }
     acol[nnza] = jcol;
     arow[nnza] = irow;
     aelt[nnza] = v[ivelt1] * scale;
   }
 }
      }
    }
    size = size * ratio;
  }
  for (i = firstrow; i <= lastrow; i++) {
    if (i >= firstcol && i <= lastcol) {
      iouter = n + i;
      nnza = nnza + 1;
      if (nnza > nz) {
 printf("Space for matrix elements exceeded in makea\n");
 printf("nnza, nzmax = %d, %d\n", nnza, nz);
 printf("iouter = %d\n", iouter);
 exit(1);
      }
      acol[nnza] = i;
      arow[nnza] = i;
      aelt[nnza] = rcond - shift;
    }
  }
  sparse(a, colidx, rowstr, n, arow, acol, aelt,
  firstrow, lastrow, v, &(iv[0]), &(iv[n]), nnza);
}
static void sparse(
     double a[],
     int colidx[],
     int rowstr[],
     int n,
     int arow[],
     int acol[],
     double aelt[],
     int firstrow,
     int lastrow,
     double x[],
     boolean mark[],
     int nzloc[],
     int nnza)
{
  int nrows;
  int i, j, jajp1, nza, k, nzrow;
  double xi;
  nrows = lastrow - firstrow + 1;
        
#pragma omp parallel for
  for (j = 1; j <= n; j++) {
    rowstr[j] = 0;
    mark[j] = 0;
  }
  rowstr[n+1] = 0;
  for (nza = 1; nza <= nnza; nza++) {
    j = (arow[nza] - firstrow + 1) + 1;
    rowstr[j] = rowstr[j] + 1;
  }
  rowstr[1] = 1;
  for (j = 2; j <= nrows+1; j++) {
    rowstr[j] = rowstr[j] + rowstr[j-1];
  }
  for (nza = 1; nza <= nnza; nza++) {
    j = arow[nza] - firstrow + 1;
    k = rowstr[j];
    a[k] = aelt[nza];
    colidx[k] = acol[nza];
    rowstr[j] = rowstr[j] + 1;
  }
  for (j = nrows; j >= 1; j--) {
    rowstr[j+1] = rowstr[j];
  }
  rowstr[1] = 1;
  nza = 0;
        
#pragma omp parallel for
  for (i = 1; i <= n; i++) {
    x[i] = 0.0;
    mark[i] = 0;
  }
  jajp1 = rowstr[1];
  for (j = 1; j <= nrows; j++) {
    nzrow = 0;
    for (k = jajp1; k < rowstr[j+1]; k++) {
      i = colidx[k];
      x[i] = x[i] + a[k];
      if ( mark[i] == 0 && x[i] != 0.0) {
 mark[i] = 1;
 nzrow = nzrow + 1;
 nzloc[nzrow] = i;
      }
    }
    for (k = 1; k <= nzrow; k++) {
      i = nzloc[k];
      mark[i] = 0;
      xi = x[i];
      x[i] = 0.0;
      if (xi != 0.0) {
 nza = nza + 1;
 a[nza] = xi;
 colidx[nza] = i;
      }
    }
    jajp1 = rowstr[j+1];
    rowstr[j+1] = nza + rowstr[1];
  }
}
static void sprnvc(
     int n,
     int nz,
     double v[],
     int iv[],
     int nzloc[],
     int mark[] )
{
  int nn1;
  int nzrow, nzv, ii, i;
  double vecelt, vecloc;
  nzrow = 0;
  nn1 = 1;
  do {
    nn1 = 2 * nn1;
  } while (nn1 < n);
  nzv = 0;
  while (nzv < nz) {
    vecelt = randlc(&tran, amult);
    vecloc = randlc(&tran, amult);
    i = icnvrt(vecloc, nn1) + 1;
    if (i > n) continue;
    if (mark[i] == 0) {
      mark[i] = 1;
      nzrow = nzrow + 1;
      nzloc[nzrow] = i;
      nzv = nzv + 1;
      v[nzv] = vecelt;
      iv[nzv] = i;
    }
  }
  for (ii = 1; ii <= nzrow; ii++) {
    i = nzloc[ii];
    mark[i] = 0;
  }
}
static int icnvrt(double x, int ipwr2) {
  return ((int)(ipwr2 * x));
}
static void vecset(
     int n,
     double v[],
     int iv[],
     int *nzv,
     int i,
     double val)
{
  int k;
  boolean set;
  set = 0;
  int nzvc = *nzv;
  for (k = 1; k <= nzvc; k++) {
    if (iv[k] == i) {
      v[k] = val;
      set = 1;
    }
  }
  if (set == 0) {
    *nzv = *nzv + 1;
    v[*nzv] = val;
    iv[*nzv] = i;
  }
}
