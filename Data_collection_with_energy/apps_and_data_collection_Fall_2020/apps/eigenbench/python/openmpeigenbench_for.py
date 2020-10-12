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
    branches = 10
    try:
        opts, args = getopt.getopt(argv,"hr:n:b:sd",["branches=","nThreads=","big=", "sched="])
    except getopt.GetoptError:
        print 'openmpeigenbench_for.py -r <for> -n nThreads -b big'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'openmpeigenbench_for.py -r <for> -n nThreads -b big'
            sys.exit()
        elif opt in ("-r", "--branches"):
            noofFor = float(arg)
        elif opt in ("-n","--nThreads"):
            nThreads = int(arg)
        elif opt in ("-b","big"):
            big = int(arg)
        elif opt in ("-sd", "--sched"):
            schedule = str(arg);

    np.random.seed()

    noofInts= (workingset * 1024 *1024 ) / 4
    noofOperations= noofInts * 20000;
    #parIterations = 2048;
    parIterationSize = 2048;
    forpercentage = noofFor
   # Iterations = int(noofOperations /  parIterationSize
    noofFor = int(noofFor)
    parIterationSize = [0] * 8

    if noofFor <= 25:
        parIterationSize[0] = 2048;
    elif noofFor <= 1000:
        parIterationSize[0] = int(np.random.uniform(0,2048))
        parIterationSize[1] = 2048 - parIterationSize[0]
        noofFor = noofFor/2
    elif noofFor <= 16000:
        left = 2048
        for i in range(3):
            parIterationSize[i] = int(np.random.uniform(0,left))
            left = left - parIterationSize[i]
        parIterationSize[3] = left
        noofFor = noofFor/4
    else:
        left = 2048
        for i in range(7):
            parIterationSize[i] = int(np.random.uniform(0,left))
            left = left - parIterationSize[i]
        parIterationSize[7] = left
        noofFor = noofFor/8


    parIterations = noofOperations / (noofFor * 2048)
    #parIterationSize = int (noofOperations / ( noofFor * parIterations ) )


    p("/*********************************************")
    p(forpercentage)
    p("The main Program generated using openMPeigen ")
    p("bench at " + str(datetime.now()))
    p(" with percentage branch operations "+str(noofFor))
    p("*********************************************/")
    p("#define _GNU_SOURCE")
    p("#include <syscall.h>")
    p("#include <sched.h>")
    p("#include <stdio.h>")
    p("#include <omp.h>")
    p("#include <stdlib.h>")
    p("#include <sys/time.h>")
    #p("#include \"energylib.h\"")
    p("#define NSIZE "+ str(noofInts))
    p("#define NTHREADS " + str(nThreads))
    p("int main (int argc, char * argv[]){")
    if nThreads == 6 and big == 2:
        p("int cpunos[6]= {0,1,2,3,4,5};")
    elif nThreads == 4 and big == 0:
        p("int cpunos[4]= {0,1,2,3};")
    elif nThreads == 2 and big == 2:
        p("int cpunos[2]= {4,5};")

    p("     struct timeval start, end;")
    p("float arr[NSIZE];")
    p("")
    p(" int i;")
    p("for(i=0;i<NSIZE;i++){")
    p(" arr[i] = i;")
    p("}")
    p("omp_set_num_threads(NTHREADS);")
    p("int cores = 255;\n ");
    #p("energymonitor__init(cores,0.1); energymonitor__startprofiling();\n");
    p("printf(\"Begin benchmark\\n\");")
    p("printf(\"Total Instructions is "+ str(noofOperations)+"\\n\");")
    p("printf(\"number of barrier operations is "+str(forpercentage)+"\\n\");")
    p("   double time;\n gettimeofday(&start,(void*)0);")
    p("int scheddata[ NTHREADS * 8];")
    p("for(i=0;i<NTHREADS;i++)")
    p("scheddata[i*8] = 0;")
    p(" # pragma omp parallel ")
    p("{")
    p(" int i=0;")
    p("int tid = omp_get_thread_num();")
    p("int pos = tid *8;")
    p("int max = NSIZE/NTHREADS - " + str(int(noofFor)) + "/3; ")
    p("  #pragma omp master ")
    p("{")
    p("printf(\"\\n\\n The number of Threads : %d\\n\",omp_get_num_threads());")

    p("}")
    p("int offset = (NSIZE/NTHREADS)*tid;")
    p("int k = 0;")
    p(" float ops1[16]={1}; float ops2=2;")
    if schedule == "dynamic" :
        p("cpu_set_t set;")
        p("CPU_ZERO(&set);")
        p("CPU_SET(cpunos[tid],&set);")
        p("int t = sched_setaffinity(syscall(SYS_gettid), sizeof(set), &set);")
        p("if(t == -1)")
        p("printf(\"Error in setting affinity\");")
    p("for (i=0;i<"+ str(int (noofFor)) +";i++){\n")
    p("int j;")
    p("ops2 = arr[i];")
    k = 0
    sizeitr = 0
    chunksize = int(parIterations/nThreads)
    if chunksize > 128:
        chunksize = 128
    while sizeitr != 8 and parIterationSize[sizeitr] != 0:
        if schedule == "dynamic" :
            p(" # pragma omp for private(j) schedule(dynamic,"+str(int(chunksize))+")")
        else :
            p(" # pragma omp for private(j) schedule(static)")
        p("for (j=0;j<"+ str(int(parIterations)) +";j++){\n")
        p("scheddata[pos] ++;")
        for num in range(0,parIterationSize[sizeitr]-1):
            k = k+1
            if k == 16:
                k = 0
            numb = int(np.random.uniform(0,parIterationSize[sizeitr]))
            if numb % 8 == 7:
                p("ops1["+str(k)+"] = ops1["+str(k)+"] - ops2;")
            elif numb % 8 == 3:
                p("ops1["+str(k)+"] = ops1["+str(k)+"] * ops2;")
            elif numb %4 == 1:
                p("ops1["+str(k)+"] = ops1["+str(k)+"] + ops2;")
            elif numb % 4 == 2:
                p("arr[i] = ops1["+str(k)+"];")
            else:
                p("ops2 = arr[i];")
        p("}")
        sizeitr = sizeitr +1
    p("arr[tid]  += ops1[0];")
    p("}")
    p("arr[tid] = ops1[3];")
    p("}")
    p("printf(\"End benchmark %f\\n\",arr[1]);")
    p("     gettimeofday(&end,(void*)0);\n ")
    p("time = (double)(end.tv_sec - start.tv_sec) + (1.0e-6*(end.tv_usec - start.tv_usec));")
    p("printf(\"Elapsed time in seconds =  %f \\n\", time);\n")
    p("for(i = 0;i<NTHREADS ; i++)")
    p("printf(\"The number of iterations scheduled in thread %d is %d\\n \", i, scheddata[i*8]);")

    p("return 0;")
    p("}")
if __name__  == "__main__" :
    main(sys.argv[1:])
