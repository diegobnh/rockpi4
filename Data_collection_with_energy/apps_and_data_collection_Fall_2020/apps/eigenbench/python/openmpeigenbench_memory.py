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
from random import seed
import numpy as np
# The orthogonal properties identified now are
# concurrency (amount of serial/parallel) workload.
# working-set size (shared memory size)
# memory operations (amount of memory / cpu operations)
# temporal locality (randomization)

def p(string):
    print string


def main(argv):
    # change on each run
    seed(153)
    nThreads = 8
    workingset = 4
    memoryoperations = 50;
    schedule = "DYNAMIC"
    try:
        opts, args = getopt.getopt(argv,"hm:n:b:sd",["con=", "mem=", "nThreads=", "big=", "sched="])
    except getopt.GetoptError:
        print 'openmpeigenbench.py  -m <memoryoperations>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'openmpeigenbench.py -c <concurrency> -m <memoryoperations>'
            sys.exit()
        elif opt in ("-m", "--mem"):
            memoryoperations = float(arg)
        elif opt in ("-n", "--nThreads"):
            nThreads = int(arg)
        elif opt in ("-b", "--big"):
            big = int(arg)

    noofInts= (workingset * 1024 *1024 ) / 4
    percentmemop = memoryoperations
    noofOperations= noofInts * 1000;
    iterationsize = 2048
    parallel = noofOperations/iterationsize
    noofMemops = (memoryoperations * iterationsize)/100
    p("/*********************************************")
    p("The main Program generated using openMPeigen ")
    p("with percentagememory operations as "+ str(percentmemop))
    p("printf(\"percentage mem ops is "+str(percentmemop)+"\\n\");")
    p("bench at " + str(datetime.now()))
    p("*********************************************/")
    p("#define _GNU_SOURCE")
    p("#include <syscall.h>")
    p("#include <sched.h>")
    p("#include <stdio.h>")
    p("#include <omp.h>")
    p("#include <stdlib.h>")
    p("#include <sys/time.h>")
    #p("#include \"energylib.h\"")
    if nThreads == 6 and big == 2:
        p("int cpunos[6]= {0,1,2,3,4,5};")
    elif nThreads == 4 and big == 0:
        p("int cpunos[4]= {0,1,2,3};")
    elif nThreads == 2 and big == 2:
        p("int cpunos[2]= {4,5};")

    p("#define NSIZE "+ str(noofInts))
    p("#define NTHREADS " + str(nThreads))
    p("#define NTOP " + str((noofInts/nThreads) - iterationsize))
    p("int main (int argc, char * argv[]){")
    p("     struct timeval start, end;")
    p("")
    p(" int i,j;")

    if schedule == "DYNAMIC":
        p("int scheddata[ NTHREADS * 8];")
        p("for(i=0;i<NTHREADS;i++)")
        p("scheddata[i*8] = 0;")

    p("omp_set_num_threads(NTHREADS);")
    p("float arr[NTHREADS][NSIZE/(NTHREADS)];")
    p("for (i=0;i<NTHREADS;i++)")
    p("  for (j=0;j<NTHREADS;j++)")
    p("       arr[i][j] = j;")
    p("int cores = 255;\n ");
    #p("energymonitor__init(cores,0.1); energymonitor__startprofiling();\n");
    p("printf(\"Begin benchmark\\n\");")
    p("printf(\"With percentage mem ops is "+str(percentmemop)+"\\n\");")
    p("printf(\"Total Instructions is "+ str(noofOperations)+"\");")
    p("   double time;\n gettimeofday(&start,(void*)0);")
#    p(" int j;")
    p(" # pragma omp parallel ")
    p("{")
    p("int itpos = 0;")
    p("int tid = omp_get_thread_num();")
    p("int pos = tid *8;")
    p("  #pragma omp master ")
    p("{")
    p("printf(\"\\n\\n The number of Threads : %d\\n\",omp_get_num_threads());")
    p("}")
    p("int k = (NSIZE/NTHREADS)*tid;")
    p(" float ops1[12]= {1}; float ops2= 2;")
    if schedule == "DYNAMIC" :
        p("cpu_set_t set;")
        p("CPU_ZERO(&set);")
        p("CPU_SET(cpunos[tid],&set);")
        p("int t = sched_setaffinity(syscall(SYS_gettid), sizeof(set), &set);")
        p("if(t == -1)")
        p("printf(\"Error in setting affinity\");")
        p(" # pragma omp for private(i) schedule(dynamic)")
    p("for (i=0;i<"+ str(parallel) +";i++){\n")
    p("scheddata[pos] ++;")
    k = 0
    for num in range(0,iterationsize):
        k = k + 1
        if k == 12:
            k = 0;
        numb = int(np.random.uniform(0,iterationsize))
        if numb < noofMemops:
            if numb % 2 == 1:
                p("arr[tid][itpos] = ops1["+str(k)+"] + 2;")
            else:
                p("ops2 = arr [tid][itpos++];" )
        else:
            if numb % 8 == 3:
                p("ops1["+str(k)+"] = ops1["+str(k)+"] / 2;" )
            elif numb % 4 == 2:
                p("ops1["+str(k)+"] = ops1["+str(k)+"] * ops2;")
            elif numb %4 == 1:
                p("ops1["+str(k)+"] = ops1["+str(k)+"] - ops2;")
            else:
                p("ops1["+str(k)+"] = ops1["+str(k)+"] + ops2;")
    p("if (itpos > NTOP)  itpos = 0;")
    p("}")
    p("printf(\"%f\",arr[tid][i]);")
    p("}")
    p("printf(\"End benchmark\\n\");")
    p("     gettimeofday(&end,(void*)0);\n ")
    p("time = (double)(end.tv_sec - start.tv_sec) + (1.0e-6*(end.tv_usec - start.tv_usec));")
    p("printf(\"Elapsed time in seconds =  %f \\n\", time);\n")
    p("for(i = 0;i<NTHREADS ; i++)")
    p("printf(\"The number of iterations scheduled in thread %d is %d\\n \", i, scheddata[i*8]);")

    p("return 0;")
    p("}")
if __name__  == "__main__" :
    main(sys.argv[1:])
