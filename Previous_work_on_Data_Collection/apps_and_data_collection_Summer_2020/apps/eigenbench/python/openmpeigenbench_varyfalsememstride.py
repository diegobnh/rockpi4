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
    workingset = 4
    falsesharing = 1;
    schedule =  "DYNAMIC" 
    try:
        opts, args = getopt.getopt(argv,"hr:m:n:b:sd",["stride=", "memory=", "nThreads=", "big=", "sched="])
    except getopt.GetoptError:
        print 
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'Handles false sharing and memory operations\n openmpeigenbench_falsesharing.py -f <YES/NO> -m memorypercentage -sd <STATIC/DYNAMIC>'
            sys.exit()
        elif opt in ("-r","--stride"):
            stride = int(arg)
        elif opt in ("-m", "--memory"):
            memoryoperations = float(arg)
        elif opt in ("-n", "--nThreads"):
            nThreads = int(arg)
        elif opt in ("-b", "--big"):
            big = int(arg)
        elif opt in ("-sd" , "--sched"):
            schedule = arg;
 

    temporallocality = 1
    readtimeperiod=0.1
    concurrency  = 1.0
    #iterationsize = 32
    iterationsize = 8192
    memoryoperations = 10
    percentmemop = memoryoperations
    percentagefalse = 80
#    memoryoperations  = (memoryoperations * iterationsize) /100
    false = (iterationsize * false) /100
    noofInts = (workingset * 1024 * 1024 ) / 4
    noofOperations= noofInts * 600;
    #noofOperations= noofOperations /1024
    parallel = noofOperations / iterationsize
    arraySize = parallel* stride

    p("/*********************************************")
    p("The main Program generated using openMPeigenbench v4 ") 
    p("bench at " + str(datetime.now()))
    p("with percentagememory operations as "+ str(percentmemop))
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
    p("#define NSIZE " + str(arraySize))
    p("#define STRIDE" + str(stride))
#    csize = arraySize/(nThreads)
#    p("#define CSIZE " + str(csize))
    p("#define NTHREADS " + str(nThreads))
    p("int main (int argc, char * argv[]){")
    p("     struct timeval start, end;")
    if nThreads == 8: 
        p("int cpunos[8]= {0,1,2,3,4,5,6,7};")
    elif nThreads == 6 and big == 4:
        p("int cpunos[6]= {2,3,4,5,6,7};")
    elif nThreads == 6 and big == 2:
        p("int cpunos[6]= {0,1,2,3,4,5};")
    elif nThreads == 4 and big == 4:
        p("int cpunos[4]= {4,5,6,7};")
    elif nThreads == 4 and big == 0:
        p("int cpunos[4]= {0,1,2,3};")
  #  p("float arr[NTHREADS][CSIZE];")
    p("float arrf[NSIZE];")
    p(" int i,j;")
    chunkSize = arraySize /(2*nThreads);
    p(" omp_set_num_threads("+ str(nThreads) +");")
    p("for(i=0;i<NSIZE;i++){")
    p(" arrf[i] = i;")
    p("}")
 #   p("for(i=0;i<NTHREADS;i++) {")
 #   p("for(j=0;j<CSIZE;j++) {")
 #   p(" arr[i][j] = j;")
  #  p("}")
#    p("}")
    if schedule == "DYNAMIC":
        p("int scheddata[ NTHREADS * 8];")
        p("for(i=0;i<NTHREADS;i++)")
        p("scheddata[i*8] = 0;")

    p("int p_rand["+ str(nThreads) +"];")
    for num in range (0,nThreads):
        prand = randint(0,10000)
        p("p_rand["+ str(num) +"] = " + str(prand) +";")
    p("energymonitor__saveastextfile(\"prof.txt\");\nenergymonitor__trackpoweronly();\n");
    p("int cores = 255;\n energymonitor__init(cores,"+str(readtimeperiod)+");\n ")
    p("printf(\"Begin benchmark\\n\");")
    p("printf(\"With Memory operations is "+str(percentmemop)+"\\n\");")
    p("printf(\"With FALSE SHARING percentage "+str(percentagefalse)+"\\n\");")
    p("printf(\"Total Instructions is "+ str(noofOperations)+"\");")
    p("   double time;\n gettimeofday(&start,(void*)0);")
    p("energymonitor__startprofiling();\n");
    p(" # pragma omp parallel ")
    p("{")
    p("int tid = omp_get_thread_num();")
    p("float ops1,ops2;")
    p("  #pragma omp master ")
    p("{")
    p("printf(\"\\n\\n The number of Threads : %d\\n\",omp_get_num_threads());")
    p("}")
    p("int pos = tid *8;")
    p("int k = tid;")
    if schedule == "DYNAMIC":
        p("  cpu_set_t set;")
        p("CPU_ZERO(&set);")
        p("CPU_SET(cpunos[tid],&set);")
        p("int t = sched_setaffinity(syscall(SYS_gettid), sizeof(set), &set);")
        p("if(t == -1)")
        p("printf(\"Error in setting affinity\");")
        p(" # pragma omp for private(i)  schedule(dynamic)")
    else :
        p(" # pragma omp for private(i) schedule(static)")
    p("for (i=0;i<"+ str(parallel) +";i++){\n")
    p("scheddata[pos]++;")
    for num in range(0,iterationsize):
       # numb = int( np.random.uniform(0,iterationsize) )
       # if numb < memoryoperations:
        numbf = int( np.random.uniform(0,iterationsize))
        if numbf < false:
            numbi = np.random.uniform(0, arraySize);
            if numbf % 2 == 1: 
                p("arrf[i * STRIDE]= ops1;")
            else:
                p("ops2 = arrf[i * STRIDE]++; ")
          #  else:
          #      numbi = np.random.uniform(0, csize);
          #      if numb % 2 == 1: 
          #          p("arr[tid]["+ str(int(numbi)) + "]= ops1;")
          #      else:
          #          p("ops2 = arr[tid]["+ str(int(numbi)) + "]++; ")
        else:
            if numbf % 8 == 3:
                p("ops1 = ops1 / 2;" )
            elif numbf % 4 == 2:
                p("ops1 = ops1 * ops2;")
            elif numbf %4 == 1:
                p("ops1 = ops1 - ops2;")
            else:
                p("ops1 = ops1 + ops2;")
                
    p("} \n }")
    p("printf(\"End benchmark %f %f\\n\",arrf[11], arrf[9]);")
    p("     gettimeofday(&end,(void*)0);\n energymonitor__stopprofiling();") 
    p("time = (double)(end.tv_sec - start.tv_sec) + (1.0e-6*(end.tv_usec - start.tv_usec));")
    p("printf(\"Elapsed time in seconds =  %f \\n\", time);\n")
    p("printf(\"The scheduling information \\n\");")
    p("for(i = 0;i<NTHREADS ; i++)")
    p("printf(\"The number of iterations scheduled in thread %d is %d\\n \", i, scheddata[i*8]);")
    p("return 0;")
    p("}")
if __name__  == "__main__" : 
    main(sys.argv[1:])
