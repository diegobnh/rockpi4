# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
import sys, getopt
from datetime import datetime 
import argparse
from random import randint
import numpy as np

def p(string):
    print string


def main(argv):
    nThreads = 8
    # The working set size
    # the size is given in MB
    workingset = 4
    # memry operations
    # 0.5 to 1
    memoryoperations = 0.5;
    # 1 means linear 
    # 0 means random
    temporallocality = 1
    readtimeperiod=0.000001
    # Expected  concurrency
    # can vary from 0 to 1
    # we are looking for 
    concurrency  = 1.0

    # length of the for iteratoin this will vary from 1
    # to 1000
    iterationsize = 1024;
    falsesharing = 1;
    schedule =  "DYNAMIC" 
    try:
        opts, args = getopt.getopt(argv,"hf:m:sd",["false=","memory="])
    except getopt.GetoptError:
        print 
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'Handles false sharing and memory operations\n openmpeigenbench_v4.py -f <YES/NO> -m [0-1] -sd <STATIC/DYNAMIC>'
            sys.exit()
        elif opt in ("-f","--false"):
            if arg == "YES":
                falsesharing = 1
            else:
                falsesharing = 0
        elif opt in ("-m", "--memory"):
            memoryoperations = float(arg)
        elif opt in ("-sd" , "--sched"):
            schedule = arg;

    memoryoperations  = memoryoperations * iterationsize
    noofInts = (workingset * 1024 * 1024 ) / 4
    noofOperations= noofInts *600;
    p("/*********************************************")
    p("The main Program generated using openMPeigenbench v4 ") 
    p("bench at " + str(datetime.now()))
    p("The for construct iteration size is" + str(iterationsize))
    p("*********************************************/")
    p("#define _GNU_SOURCE")
    p("#include <syscall.h>")
    p("#include <sched.h>")
    p("#include <stdio.h>")
    p("#include <omp.h>")
    p("#include <stdlib.h>")
    p("#include <math.h>")
    p("#include <sys/time.h>")
    p("#include \"energylib.h\"")
    p("#define NSIZE "+ str(noofInts))
    p("#define NTHREADS " + str(nThreads))
    p("int main (int argc, char * argv[]){")
    p("     struct timeval start, end;")
    p("int arr[NSIZE];")
    p("")
    p(" int i;")
    p(" omp_set_num_threads("+ str(nThreads) +");")
    p("for(i=0;i<NSIZE;i++){")
    p(" arr[i] = i;")
    p("}")
    if schedule == "DYNAMIC":
        p("int scheddata[ NTHREADS];")
        p("for(i=0;i<NTHREADS;i++)")
        p("scheddata[i] = 0;")
    parallel = noofOperations / iterationsize

    p("int p_rand["+ str(nThreads) +"];")
    for num in range (0,nThreads):
        prand = randint(0,10000)
        p("p_rand["+ str(num) +"] = " + str(prand) +";")
    p("energymonitor__saveastextfile(\"prof.txt\");\nenergymonitor__trackpoweronly();\n");
    p("int cores = 255;\n energymonitor__init(cores,"+str(readtimeperiod)+");\n ")
    p("printf(\"Begin benchmark\\n\");")
    p("   double time;\n gettimeofday(&start,(void*)0);")
    p("int pvar= 0;")
    p("energymonitor__startprofiling();\n");
    p(" # pragma omp parallel ")
    p("{")
    p("int tid = omp_get_thread_num();")
    p("  #pragma omp master ")
    p("{")
    p("printf(\"\\n\\n The number of Threads : %d\\n\",omp_get_num_threads());")
    p("}")
    p("int k = tid;")
    if schedule == "dynamic" and false == 0:
        p("  cpu_set_t set;")
        p("CPU_ZERO(&set);")
        p("CPU_SET(tid,&set);")
        p("int t = sched_setaffinity(syscall(SYS_gettid), sizeof(set), &set);")
        p("if(t == -1)")
        p("printf(\"Error in setting affinity\");")
        p(" # pragma omp for private(i,pvar)  schedule(dynamic)")
    else :
        p(" # pragma omp for private(i,pvar) schedule(static)")
    p("for (i=0;i<"+ str(parallel) +";i++){\n")
    p("scheddata[tid]++;")
    if np.random.uniform(0,iterationsize) < memoryoperations:
        p("arr[k] = arr[k+ NTHREADS ] + arr[k] ;")
    else:
        if falsesharing == 0:
            p("if (k >= (NSIZE/NTHREADS)*tid + 1)")
            p("       k = (NSIZE/NTHREADS)*tid;")
        else:
            p("k = " + str(np.random.uniform(0,noofInts-2*nThreads-1)) +"+ tid;")
    p("} \n }")
    p("printf(\"End benchmark %d\\n\",arr[1]);")
    p("     gettimeofday(&end,(void*)0);\n energymonitor__stopprofiling();") 
    p("time = (double)(end.tv_sec - start.tv_sec) + (1.0e-6*(end.tv_usec - start.tv_usec));")
    p("printf(\"Elapsed time in seconds =  %f \\n\", time);\n")
    p("printf(\"The scheduling information \\n\");")
    p("for(i = 0;i<NTHREADS ; i++)")
    p("printf(\"The number of iterations scheduled in thread %d is %d\\n \", i, scheddata[i]);")
    p("return 0;")
    p("}")
if __name__  == "__main__" : 
    main(sys.argv[1:])
