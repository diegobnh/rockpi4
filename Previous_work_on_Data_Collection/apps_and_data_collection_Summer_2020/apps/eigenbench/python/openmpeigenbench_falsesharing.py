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
    workingset = 4
    schedule =  "DYNAMIC"
    try:
        opts, args = getopt.getopt(argv,"h:f:n:b:r",["false=", "nThreads=", "big=", "stride="])
    except getopt.GetoptError:
        print
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'Handles false sharing and memory operations\n openmpeigenbench_falsesharing.py -f falsepercentage -m memorypercentage -r stride'
            sys.exit()
        elif opt in ("-f","--false"):
            false = float(arg)
        elif opt in ("-n", "--nThreads"):
            nThreads = int(arg)
        elif opt in ("-b", "--big"):
            big = int(arg)
        elif opt == "-r":
            stride = int(argv[7]);


    temporallocality = 1
    readtimeperiod=0.1
    concurrency  = 1.0
    iterationsize = 2048
    percentagefalse = false
    false = (iterationsize * false) /100
    noofInts = (workingset * 1024 * 1024 ) / 4
    noofOperations= noofInts * 1000;
    parallel = noofOperations / iterationsize
    arraySize = parallel *2

    p("/*********************************************")
    p("The main Program generated using openMPeigenbench v4 ")
    p("bench at " + str(datetime.now()))
    p("with percentage of false sharing as " + str(percentagefalse))
    p("with stride value " + str(stride))
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
    #p("#include \"energylib.h\"")
    p("#define NSIZE " + str(arraySize))
#    csize = arraySize/(nThreads)
#    p("#define CSIZE " + str(csize))
    p("#define NTHREADS " + str(nThreads))
    p("int main (int argc, char * argv[]){")
    p("     struct timeval start, end;")
    if nThreads == 6 and big == 2:
        p("int cpunos[6]= {0,1,2,3,4,5};")
    elif nThreads == 4 and big == 0:
        p("int cpunos[4]= {0,1,2,3};")
    elif nThreads == 2 and big == 2:
        p("int cpunos[2]= {4,5};")
    p("float arrf[NSIZE];")
    p(" int i,j;")
    chunkSize = arraySize /(2*nThreads);
    p(" omp_set_num_threads("+ str(nThreads) +");")
    p("for(i=0;i<NSIZE;i++){")
    p(" arrf[i] = i;")
    p("}")
    p("int scheddata[ NTHREADS * 8];")
    p("for(i=0;i<NTHREADS;i++)")
    p("scheddata[i*8] = 0;")

    p("int p_rand["+ str(nThreads) +"];")
    for num in range (0,nThreads):
        prand = randint(0,10000)
        p("p_rand["+ str(num) +"] = " + str(prand) +";")
    #p("energymonitor__saveastextfile(\"prof.txt\");\nenergymonitor__trackpoweronly();\n");
    p("int cores = 255;\n ")
    p("printf(\"Begin benchmark\\n\");")
#    p("printf(\"With Memory operations is "+str(percentmemop)+"\\n\");")
    p("printf(\"With FALSE SHARING percentage "+str(percentagefalse)+"\\n\");")
    p("printf(\"With STRIDE "+str(stride)+"\\n\");")
    p("printf(\"Total Instructions is "+ str(noofOperations)+"\");")
    p("   double time;\n gettimeofday(&start,(void*)0);")
    #p("energymonitor__startprofiling();\n");
    p(" # pragma omp parallel ")
    p("{")
    p("int tid = omp_get_thread_num();")
    p("int A =" + str(nThreads*stride) + ";")
    p("int B = tid * " + str(stride) + ";")
    p("float ops1=0,ops2=1;")
    p("  #pragma omp master ")
    p("{")
    p("printf(\"\\n\\n The number of Threads : %d\\n\",omp_get_num_threads());")
    p("}")
    p("int pos = tid *8;")
    p("int k = tid;")
    p("  cpu_set_t set;")
    p("CPU_ZERO(&set);")
    p("CPU_SET(cpunos[tid],&set);")
    p("int t = sched_setaffinity(syscall(SYS_gettid), sizeof(set), &set);")
    p("int index = 0;")
    p("if(t == -1)")
    p("printf(\"Error in setting affinity\");")
    p(" # pragma omp for private(i)  schedule(dynamic)")
    p("for (i=0; i<"+ str(parallel) +"; i++) {\n")
    p("scheddata[pos]++;")
    for num in range(0,int(iterationsize + false)):
        numbf = int( np.random.uniform(0,iterationsize))
        if numbf < false:
                p("arrf[A * index + B]= ops1;")
        else:
            if numbf % 16 == 3:
                p("ops1 = ops1 / 2;" )
            elif numbf % 4 == 2:
                p("ops1 = ops1 * ops2;")
            elif numbf %4 == 1:
                p("ops1 = ops1 - ops2;")
            elif numbf % 8 == 7 or numbf % 16 == 11 :
                p("index++;")
            else:
                p("ops1 = ops1 + ops2;")
    p("if( (index+ 512) * A  > NSIZE) index = 0;")
    p("} \n }")
    p("printf(\"End benchmark %f %f\\n\",arrf[11], arrf[9]);")
    p("     gettimeofday(&end,(void*)0);\n ")
    p("time = (double)(end.tv_sec - start.tv_sec) + (1.0e-6*(end.tv_usec - start.tv_usec));")
    p("printf(\"Elapsed time in seconds =  %f \\n\", time);\n")
    p("printf(\"The scheduling information \\n\");")
    p("for(i = 0;i<NTHREADS ; i++)")
    p("printf(\"The number of iterations scheduled in thread %d is %d\\n \", i, scheddata[i*8]);")
    p("return 0;")
    p("}")
if __name__  == "__main__" :
    main(sys.argv[1:])
