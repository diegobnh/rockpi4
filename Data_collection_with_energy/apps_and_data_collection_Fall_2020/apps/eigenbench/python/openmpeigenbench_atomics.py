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
    workingset = 4
    memoryoperations = 0.5;
    temporallocality = 1
    atomics = 0
    schedule =  "DYNAMIC"
    iterationsize = 8192
    readtimeperiod = 0.1
    try:
        opts, args = getopt.getopt(argv,"ha:n:b:sd",["atomics=","nThreads=","big=", "sched="])
       # print opts,args
    except getopt.GetoptError:
        print "NO Way"
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'openmpeigenbench_atomics.py -a atomicpercentage -n nThreads -b big -sd <STATIC/DYNAMIC>'
            sys.exit()
        elif opt in "-a":
            atomics = float(arg)
        elif opt in ("-n", "--nThreads"):
            nThreads = int(arg)
        elif opt in ("-b", "--big"):
            big = int(arg)
        elif opt in ("-sd" , "--sched"):
            schedule = arg;

    schedule = "DYNAMIC"
    noofInts= (workingset * 1024 *1024 ) / 4
    noofOperations= noofInts *600;
    percentageatomics = atomics
    atomics = (atomics * iterationsize) /100


    p("/*********************************************")
    p("The main Program generated using openMPeigenbench v3 ")
    p("bench at " + str(datetime.now()))
    p("The for construct iteration size is" + str(iterationsize))
    p("with percentage of atomic operations " + str(percentageatomics))
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
    #p("#include \"energylib.h\"")
    p("#define NSIZE "+ str(noofInts))
    p("#define NTHREADS " + str(nThreads))

    if nThreads == 6 and big == 2:
        p("int cpunos[6]= {0,1,2,3,4,5};")
    elif nThreads == 2 and big == 2:
        p("int cpunos[4]= {4,5};")
    elif nThreads == 4 and big == 0:
        p("int cpunos[4]= {0,1,2,3};")

    p("int main (int argc, char * argv[]){")
    p("     struct timeval start, end;")
 #   if schedule != "DYNAMIC":
##        p("int arr[NSIZE];")
    p("")
    p(" int i;")
    p(" omp_set_num_threads("+ str(nThreads) +");")
    # p("for(i=0;i<NSIZE;i++){")
    # p(" arr[i] = i;")
    # p("}")
    p("int shared;")
    if schedule == "DYNAMIC":
        p("int scheddata[ NTHREADS * 8];")
        p("for(i=0;i<NTHREADS;i++)")
        p("scheddata[i*8] = 0;")
    parallel = noofOperations / iterationsize
    p("int p_rand["+ str(nThreads) +"];")
    for num in range (0,nThreads):
        prand = randint(0,10000)
        p("p_rand["+ str(num) +"] = " + str(prand) +";")
    #p(" energymonitor__saveastextfile(\"prof.txt\"); \nenergymonitor__trackpoweronly();\n");
    p("int cores = 255;\n ")
    p("printf(\"Begin benchmark\\n\");")
    p("printf(\"Total Instructions is "+ str(noofOperations)+"\");")
    p("printf(\"percentage of atomic operations is "+str(percentageatomics)+"\\n\");")
    p("   double time;\n gettimeofday(&start,(void*)0);")
    #p("energymonitor__startprofiling();\n");
    p(" # pragma omp parallel ")
    p("{")
    p("int tid = omp_get_thread_num();")
    p("int pos = tid *8;")
    localbufsize = 256;
  #  p("int local ["+str(localbufsize)+"];")
    p("float op1, op2;")
    p("  #pragma omp master ")
    p("{")
    p("printf(\"\\n\\n The number of Threads : %d\\n\",omp_get_num_threads());")

    p("}")
    p("int k = (NSIZE/NTHREADS)*tid;")
    if schedule == "DYNAMIC" :
        p("cpu_set_t set;")
        p("CPU_ZERO(&set);")
        p("CPU_SET(cpunos[tid],&set);")
        p("int t = sched_setaffinity(syscall(SYS_gettid), sizeof(set), &set);")
        p("if(t == -1)")
        p("printf(\"Error in setting affinity\");")
        p(" # pragma omp for private(i) schedule(dynamic)")

    p("for (i=0;i<"+ str(parallel) +";i++){\n")
    p("scheddata[pos]++;");
    p("k = i%256;")
    for num in range(0,iterationsize):
        numb =  np.random.uniform(0,iterationsize)
        if numb >= atomics:
            if numb%8 == 7:
                p("op1 = op1 / op2;")
            elif numb%4 == 2:
                p("op1 = op1 * op2; ")
            elif numb%4 == 1:
                p("op1 = op1 - op2; ")
            else :
                p("op1 = op1 + op2; ")
 #           p("local["+ str(int(np.random.uniform(0,localbufsize))) + "] += 2 + local[" + str(int(np.random.uniform(0,localbufsize))) + "] + local["+ str(int(np.random.uniform(0,localbufsize))) +"];")
        else:
            if numb %16 == 1:
                p("#pragma omp atomic read")
                p("op2 = shared;")
            elif num %4 == 2:
                p("#pragma omp atomic update")
                p("shared += op1;")
            else:
                p("#pragma omp atomic write")
                p("shared = op1;")
    p("}\n}")
    p("printf(\"End benchmark %d\\n\",shared);")
    p(" gettimeofday(&end,(void*)0);\n ")
    p("time = (double)(end.tv_sec - start.tv_sec) + (1.0e-6*(end.tv_usec - start.tv_usec));")
    p("printf(\"Elapsed time in seconds =  %f \\n\", time);\n")
    p("printf(\"The scheduling information \\n\");")
    p("for(i = 0;i<NTHREADS ; i++)")
    p("printf(\"The number of iterations scheduled in thread %d is %d\\n \", i, scheddata[i*8]);")
    p("return 0;")
    p("}")
if __name__  == "__main__" :
    main(sys.argv[1:])
