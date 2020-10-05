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
    critical = 0;
    schedule =  "DYNAMIC"
    try:
        opts, args = getopt.getopt(argv,"hc:n:b:sd",["critical=","nThreads=","big=", "sched="])
    except getopt.GetoptError:
        print "NO Way"
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'openmpeigenbench_critical.py  -c <critical> -n nThreads -b big -sd <STATIC/DYNAMIC>'
            sys.exit()
        elif opt in "-c":
            critical = float(arg)
        elif opt in ("-n", "--nThreads"):
            nThreads = int(arg)
        elif opt in ("-b", "--big"):
            big = int(arg)
        elif opt in ("-sd" , "--sched"):
            schdule = "DYNAMIC"
    noofInts = (workingset * 1024 *1024) /  4
    noofOperations = noofInts *1000;
    np.random.seed()
    iterationsize1 = int(np.random.uniform(0,2048))
    parallel1 = noofOperations / iterationsize1
    critical = int(critical)
    if critical < 20:
        iterationsize2 = 2048 - iterationsize1 -1
        iterationsize3 = 0;
        #critical containing loop with 1 statments
        i3stmt = 1 * critical
        parallel2 = int((noofOperations - (iterationsize1*parallel1 + i3stmt )) / ((2048 - iterationsize1)))
    elif critical < 2000:
        iterationsize2 = 2048 - iterationsize1 - 2
        #critical containing loop with 2 statments
        iterationsize3 = 1;
        i3stmt = 2 * critical
        parallel2 = int((noofOperations - (iterationsize1*parallel1 + i3stmt )) / ((2048 - iterationsize1)))

    else:
        iterationsize3 = 10
        iterationsize2 = 2048 - iterationsize1
        #critical containing loop with 8 statments
        iterationsize3 = 7
        i3stmt = 8 * critical
        parallel2 = int((noofOperations - (iterationsize1*parallel1 + i3stmt )) / ((2048 - iterationsize1)))

    percentagecritical = critical
    critical = int((critical))
    p("/*********************************************")
    print critical
    print noofOperations
    print percentagecritical
    p("The main Program generated using openMPeigenbench v3 ")
    p("bench at " + str(datetime.now()))
    p("The for construct iteration size is" + str(iterationsize1))
    p("with percentage of operations in critcal section is " + str(percentagecritical))
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
    p("#define NSIZE "+ str(noofInts))
    p("#define NTHREADS " + str(nThreads))
    p("int main (int argc, char * argv[]){")
    p("     struct timeval start, end;")

    if nThreads == 6 and big == 2:
        p("int cpunos[6]= {0,1,2,3,4,5};")
    elif nThreads == 4 and big == 0:
        p("int cpunos[4]= {0,1,2,3};")
    elif nThreads == 2 and big == 2:
        p("int cpunos[2]= {5,6};")
    nowait = 1
    p("float shared;")
    p("")
    p(" int i;")
    p(" omp_set_num_threads("+ str(nThreads) +");")
    # p("for(i=0;i<NSIZE;i++){")
    # p(" arr[i] = i;")
    # p("}")
    if schedule == "DYNAMIC":
        p("int scheddata[ NTHREADS *8];")
        p("for(i=0;i<NTHREADS;i++)")
        p("scheddata[i*8] = 0;")
    p("int p_rand["+ str(nThreads) +"];")
    for num in range (0,nThreads):
        prand = randint(0,10000)
        p("p_rand["+ str(num) +"] = " + str(prand) +";")

    p("int cores = 255;\n ")
    p("printf(\"Begin benchmark\\n\");")
    p("printf(\"percentage of operations in critical section is "+str(percentagecritical)+"\\n\");")
    p("printf(\"Total Instructions is "+ str(noofOperations)+"\");")
    p("   double time;\n gettimeofday(&start,(void*)0);")
    p(" # pragma omp parallel ")
    p("{")
    p("int tid = omp_get_thread_num();")
    p("  #pragma omp master ")
    p("{")
    p("printf(\"\\n\\n The number of Threads : %d\\n\",omp_get_num_threads());")
    p("}")
    p("int k = (NSIZE/NTHREADS)*tid;")
    p("float op1[8], op2;")
    #   p("  cpu_set_t set;")
    #  p("CPU_ZERO(&set);")
    #  p("CPU_SET(cpunos[tid],&set);")
    #  p("int t = sched_setaffinity(syscall(SYS_gettid), sizeof(set), &set);")
    #  p("if(t == -1)")
    #  p("printf(\"Error in setting affinity\");")
    #  if nowait == 1:
    #     p(" # pragma omp for private(i) schedule(dynamic) nowait")
    #  else:
    #      p(" # pragma omp for private(i) schedule(dynamic)")
    p(" # pragma omp for private(i) schedule(static) nowait")
    p("for (i=0;i<"+ str(parallel1) +";i++){\n")
    p("scheddata[tid*8]++;");
    localbufsize = 256;
    p("k = i%NSIZE;")
    skip = 0
    totItr = iterationsize1
    k = 0;
    for num in range(0,totItr):
        if k == 7:
            k = 0
        k = k + 1
        criticalsize= int(np.random.uniform(0,totItr))
        if criticalsize%8 == 7:
            p("op1["+str(k)+"] = op1["+str(k)+"] * op2;")
        elif criticalsize%4 == 2:
            p("op1["+str(k)+"] = op1["+str(k)+"] * op2; ")
        elif criticalsize%4 == 1:
            p("op1["+str(k)+"] = op1["+str(k)+"] - op2; ")
        else :
            p("op1["+str(k)+"] = op1["+str(k)+"] + op2; ")
    skip = skip -1
    p(" }")

    k = 0;
    p("#pragma omp for nowait ")
    p("for (i=0;i<"+ str(critical) +";i++){\n")
    p("scheddata[tid*8]++;");
    for i in range(0,iterationsize3/2):
        k = k + 1
        criticalsize= int(np.random.uniform(0,totItr))
        if criticalsize%8 == 7:
            p("op1["+str(k)+"] = op1["+str(k)+"] * op2;")
        elif criticalsize%4 == 2:
            p("op1["+str(k)+"] = op1["+str(k)+"] * op2; ")
        elif criticalsize%4 == 1:
            p("op1["+str(k)+"] = op1["+str(k)+"] - op2; ")
        else :
            p("op1["+str(k)+"] = op1["+str(k)+"] + op2; ")

    p("#pragma omp critical")
    p("{")
    cr = int(np.random.uniform(0,critical))
    if cr %2 ==1 :
        p("shared -= op1["+str(k)+"];")
    else :
        p("shared += op2;")
    p(" }")

    for i in range(0,iterationsize3-iterationsize3/2):
        k = k + 1
        criticalsize= int(np.random.uniform(0,totItr))
        if criticalsize%8 == 7:
            p("op1["+str(k)+"] = op1["+str(k)+"] * op2;")
        elif criticalsize%4 == 2:
            p("op1["+str(k)+"] = op1["+str(k)+"] * op2; ")
        elif criticalsize%4 == 1:
            p("op1["+str(k)+"] = op1["+str(k)+"] - op2; ")
        else :
            p("op1["+str(k)+"] = op1["+str(k)+"] + op2; ")

    p("   }")

    totItr = iterationsize2
    k = 0;
    #    if nowait == 1:
    #       p(" # pragma omp for private(i) schedule(dynamic) nowait")
    #   else:
    #       p(" # pragma omp for private(i) schedule(dynamic)")
    p(" # pragma omp for private(i) schedule(static) nowait")
    p("for (i=0;i<"+ str(parallel2) +";i++){\n")
    p("scheddata[tid*8]++;");
    for num in range(0,totItr-1):
        if k == 7:
            k = 0
        k = k + 1
        criticalsize= int(np.random.uniform(0,totItr))
        if criticalsize%8 == 7:
            p("op1["+str(k)+"] = op1["+str(k)+"] * op2;")
        elif criticalsize%4 == 2:
            p("op1["+str(k)+"] = op1["+str(k)+"] * op2; ")
        elif criticalsize%4 == 1:
            p("op1["+str(k)+"] = op1["+str(k)+"] - op2; ")
        else :
            p("op1["+str(k)+"] = op1["+str(k)+"] + op2; ")
    skip = skip -1

    p("}\n}")
    p("printf(\"End benchmark %f\\n\",shared);")
    p("     gettimeofday(&end,(void*)0);\n")
    p("time = (double)(end.tv_sec - start.tv_sec) + (1.0e-6*(end.tv_usec - start.tv_usec));")
    p("printf(\"Elapsed time in seconds =  %f \\n\", time);\n")
    p("printf(\"The scheduling information \\n\");")
    p("for(i = 0;i<NTHREADS ; i++)")
    p("printf(\"The number of iterations scheduled in thread %d is %d\\n \", i, scheddata[i*8]);")
    p("return 0;")
    p("}")
if __name__  == "__main__" :
    main(sys.argv[1:])
