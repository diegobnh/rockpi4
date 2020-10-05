#include "is_pre.h"
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
typedef int INT_TYPE;
INT_TYPE *key_buff_ptr_global;
int passed_verification;
INT_TYPE key_array[(1 << 23)],
  key_buff1[(1 << 23)],
  key_buff2[(1 << 23)],
  partial_verify_vals[5];
INT_TYPE test_index_array[5],
  test_rank_array[5],
  S_test_index_array[5] =
  {48427,17148,23627,62548,4431},
  S_test_rank_array[5] =
    {0,18,346,64917,65463},
  W_test_index_array[5] =
      {357773,934767,875723,898999,404505},
  W_test_rank_array[5] =
	{1249,11698,1039987,1043896,1048018},
  A_test_index_array[5] =
	  {2112377,662041,5336171,3642833,4250760},
  A_test_rank_array[5] =
	    {104,17523,123928,8288932,8388264},
  B_test_index_array[5] =
	      {41869,812306,5102857,18232239,26860214},
  B_test_rank_array[5] =
		{33422937,10244,59149,33135281,99},
  C_test_index_array[5] =
		  {44172927,72999161,74326391,129606274,21736814},
  C_test_rank_array[5] =
		    {61147,882988,266290,133997595,133525895};
double randlc( double *X, double *A );
void full_verify( void );
double randlc(X, A)
     double *X;
     double *A;
{
  static int KS=0;
  static double R23, R46, T23, T46;
  double T1, T2, T3, T4;
  double A1;
  double A2;
  double X1;
  double X2;
  double Z;
  int i, j;
  if (KS == 0)
    {
      R23 = 1.0;
      R46 = 1.0;
      T23 = 1.0;
      T46 = 1.0;
      for (i=1; i<=23; i++)
        {
          R23 = 0.50 * R23;
          T23 = 2.0 * T23;
        }
      for (i=1; i<=46; i++)
        {
          R46 = 0.50 * R46;
          T46 = 2.0 * T46;
        }
      KS = 1;
    }
  T1 = R23 * *A;
  j = T1;
  A1 = j;
  A2 = *A - T23 * A1;
  T1 = R23 * *X;
  j = T1;
  X1 = j;
  X2 = *X - T23 * X1;
  T1 = A1 * X2 + A2 * X1;
  j = R23 * T1;
  T2 = j;
  Z = T1 - T23 * T2;
  T3 = T23 * Z + A2 * X2;
  j = R46 * T3;
  T4 = j;
  *X = T3 - T46 * T4;
  return(R46 * *X);
}
void create_seq( double seed, double a )
{
  double x;
  int i, j, k;
  k = (1 << 19)/4;
  for (i=0; i<(1 << 23); i++)
    {
      x = randlc(&seed, &a);
      x += randlc(&seed, &a);
      x += randlc(&seed, &a);
      x += randlc(&seed, &a);
      key_array[i] = k*x;
    }
}
void full_verify()
{
  INT_TYPE i, j;
  INT_TYPE k;
  INT_TYPE m, unique_keys;
  for( i=0; i<(1 << 23); i++ )
    key_array[--key_buff_ptr_global[key_buff2[i]]] = key_buff2[i];
  j = 0;
  for( i=1; i<(1 << 23); i++ )
    if( key_array[i-1] > key_array[i] )
      j++;
  if( j != 0 )
    {
      printf( "Full_verify: number of keys out of sort: %d\n",
	      j );
    }
  else
    passed_verification++;
}
void rank( int iteration )
{
  INT_TYPE i, j, k;
  INT_TYPE l, m;
  INT_TYPE shift = 19 - 10;
  INT_TYPE key;
  INT_TYPE min_key_val, max_key_val;
  INT_TYPE prv_buff1[(1 << 19)];
        
#pragma omp master
  {
    key_array[iteration] = iteration;
    key_array[iteration+10] = (1 << 19) - iteration;
    for( i=0; i<5; i++ )
      partial_verify_vals[i] = key_array[test_index_array[i]];
    for( i=0; i<(1 << 19); i++ )
      key_buff1[i] = 0;
  }
        
#pragma omp barrier
  for (i=0; i<(1 << 19); i++)
    prv_buff1[i] = 0;
        
#pragma omp for nowait
  for( i=0; i<(1 << 23); i++ ) {
    key_buff2[i] = key_array[i];
    prv_buff1[key_buff2[i]]++;
  }
  for( i=0; i<(1 << 19)-1; i++ )
    prv_buff1[i+1] += prv_buff1[i];
        
#pragma omp critical
  {
    for( i=0; i<(1 << 19); i++ )
      key_buff1[i] += prv_buff1[i];
  }
        
#pragma omp barrier
        
#pragma omp master
  {
    for( i=0; i<5; i++ )
      {
        k = partial_verify_vals[i];
        if( 0 <= k && k <= (1 << 23)-1 )
	  if( i <= 2 )
	    {
	      if( key_buff1[k-1] !=
		  test_rank_array[i]+(iteration-1) )
		{
		  printf( "Failed partial verification: "
			  "iteration %d, test key %d\n",
			  iteration, i );
		}
	      else
		passed_verification++;
	    }
	  else
	    {
	      if( key_buff1[k-1] !=
		  test_rank_array[i]-(iteration-1) )
		{
		  printf( "Failed partial verification: "
			  "iteration %d, test key %d\n",
			  iteration, i );
		}
	      else
		passed_verification++;
	    }
      }
    if( iteration == 10 )
      key_buff_ptr_global = key_buff1;
  }
}

main( argc, argv )
int argc;
char **argv;
{
  int i, iteration, itemp;
  int nthreads = 1;
  double timecounter, maxtime;
  for( i=0; i<5; i++ ) {
    test_index_array[i] = A_test_index_array[i];
    test_rank_array[i] = A_test_rank_array[i];
  }
  printf( "\n\n NAS Parallel Benchmarks 2.3 OpenMP C version"
	  " - IS Benchmark\n\n" );
  printf( " Size:  %d  (class %c)\n", (1 << 23), 'A' );
  printf( " Iterations:   %d\n", 10 );
  printf( " Number of available threads:  %d\n", omp_get_max_threads() );

  timer_clear( 0 );
  create_seq( 314159265.00,
	      1220703125.00 );
        
#pragma omp parallel
  rank( 1 );
  passed_verification = 0;
  printf("Passed verification %d\n", passed_verification);

  if( 'A' != 'S' ) printf( "\n   iteration\n" );
  energymonitor__setfilename("is.csv");
  energymonitor__init(cores, 1);
  energymonitor__trackpoweronly();
  energymonitor__startprofiling();
  timer_start( 0 );
        
#pragma omp parallel private(iteration)
  {
    for( iteration=1; iteration<=10; iteration++ )
      {
        
#pragma omp master
	printf( "        %d\n", iteration );
	rank( iteration );
	//    printf("Passed verification %d\n", passed_verification);
#pragma omp master
	nthreads = omp_get_num_threads();
      }
  }
  timer_stop( 0 );
  //  printf("start point  = %f \n elapsed point = %f", start[0], elapsed[0]);
 
  energymonitor__stopprofiling();
  timecounter = timer_read( 0 );
  // printf("Passed verification %d\n", passed_verification);
  full_verify();
  // printf("Passed verification %d\n", passed_verification);
  if( passed_verification != 5*10 + 1 )
    passed_verification = 0;
  c_print_results( "IS",
		   'A',
		   (1 << 23),
		   0,
		   0,
		   10,
		   nthreads,
		   timecounter,
		   ((double) (10*(1 << 23)))
		   /timecounter/1000000.,
		   "keys ranked",
		   passed_verification,
		   "2.3",
		   "10 Sep 2016",
		   "gcc",
		   "g++",
		   "-lenergymodule",
		   "-I../common -I../../../workspace/testmonito...",
		   "-O3 -lm -fopenmp -lenergymodule ",
		   "(none)",
		   "randlc");
}
