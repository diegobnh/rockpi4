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
# The orthogonal properties identified now are 
# concurrency (amount of serial/parallel) workload.
# working-set size (shared memory size)
# memory operations (amount of memory / cpu operations)
# temporal locality (randomization)

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
    reduction = 0
    critical = 0;
    atomics = 0
    schedule =  "DYNAMIC" 
    iterationsize = 1024
    readtimeperiod = 0.1
    try:
        opts, args = getopt.getopt(argv,"hi:c:a:r:sd",["red=","atomics=","critical=", "sched="])
       # print opts,args
    except getopt.GetoptError:
        print "NO Way"
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'openmpeigenbench_v3.py -i itrsize -c <critical> -a <atomics> -r <YES/NO> -sd <STATIC/DYNAMIC>'
            sys.exit()
        elif opt == "-i":
            #            print >> sys.stderr.write(arg)
            iterationsize = int(arg)
            #iterationsize = 1024
        elif opt in ("-c", "--critical"):
        #    print arg
            critical = int(arg)
        elif opt in ("-a", "--atomics"):
            atomics = int(arg)
        elif opt in ("-r","--reductions"):
            if arg == "YES":
                reductions = 1
            else:
                reductions = 0
        elif opt in ("-sd" , "--sched"):
            schedule = arg;


    noofInts= (workingset * 1024 *1024 ) / 4
    noofOperations= noofInts *800;
    critical = critical * iterationsize / 100
    atomics = atomics * iterationsize /100
    #reductions = reductions * iterationsize/100
    reductionops = ["+","^","||","&&","/","*","&","+","-"]
    p("/*********************************************")
    p("The main Program generated using openMPeigenbench v3 ") 
    p("bench at " + str(datetime.now()))
    p("The for construct iteration size is" + str(iterationsize))
    p("realized without any loop inside for construct")
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
    p(" energymonitor__saveastextfile(\"prof.txt\"); \nenergymonitor__trackpoweronly();\n");
    p("int cores = 255;\n energymonitor__init(cores,"+str(readtimeperiod)+");\n ")
    p("printf(\"Begin benchmark\\n\");")
    p("   double time;\n gettimeofday(&start,(void*)0);")
    p("energymonitor__startprofiling();\n");
    p(" # pragma omp parallel ")
    p("{")
    p("int tid = omp_get_thread_num();")
    #if reduction == 1:
    p("  int reducedvalue = 0;")
    p("  #pragma omp master ")
    p("{")
    p("printf(\"\\n\\n The number of Threads : %d\\n\",omp_get_num_threads());")
    p("}")
    p("int k = (NSIZE/NTHREADS)*tid;")
    if schedule == "DYNAMIC" :
        p("  cpu_set_t set;")
        p("CPU_ZERO(&set);")
        p("CPU_SET(tid,&set);")
        p("int t = sched_setaffinity(syscall(SYS_gettid), sizeof(set), &set);")
        p("if(t == -1)")
        p("printf(\"Error in setting affinity\");")
        if reduction == 1:
            p(" # pragma omp for private(i) schedule(dynamic) reduce("+ reductionops[0]+":reducedvalue)")
        else:
            p(" # pragma omp for private(i) schedule(dynamic) private(reducedvalue)")
    else :
        if reduction == 1:
            p(" # pragma omp for private(i) schedule(static) reduce("+ reductionops[0]+":reducedvalue)")
        else:
            p(" # pragma omp for private(i) schedule(static) private(reducedvalue)")
    p("for (i=0;i<"+ str(parallel) +";i++){\n")
    p("scheddata[tid]++;");
    localbufsize = 256;
    p("int local ["+str(localbufsize)+"];")
    p("k = i%NSIZE;")
    skip = 0
    for num in range(0,iterationsize): 
        if skip == 0:
            criticalsize = np.random.uniform(0,iterationsize) 
            if criticalsize < critical:
                p("#pragma omp critical")
                p("{")
                for cr in range(0,int(criticalsize)):
                    p("arr[k] -= local["+ str(int(np.random.uniform(0,localbufsize)))+"];")
                p("}")
                skip = criticalsize
                critical = critical - criticalsize
            elif np.random.uniform(0,iterationsize) < atomics: 
                p("#pragma omp atomic")
                p("arr[k] -= local["+ str(int(np.random.uniform(0,localbufsize)))+"];")
            else: 
                p("local["+ str(int(np.random.uniform(0,localbufsize))) + "] += 2 + local[" + str(int(np.random.uniform(0,localbufsize))) + "] + local["+ str(int(np.random.uniform(0,localbufsize))) +"];")
        else:
            skip = skip -1
    if reduction == 1:
        p("reducedvalue = reducedvalue "+ reductionops[0]+ "arr[k];")
    p("}\n}")
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
