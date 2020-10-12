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
    reduction = 1
    schedule =  "DYNAMIC"
    iterationsize = 2048
    readtimeperiod = 0.1
    try:
        opts, args = getopt.getopt(argv,"hr:n:b:sd",["red=","nThreads","big=", "sched="])
    except getopt.GetoptError:
        print "NO Way"
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'openmpeigenbench_reductions.py -r <reductions> -n nThreads -b big -sd <STATIC/DYNAMIC>'
            sys.exit()
        elif opt in ("-r", "--reductions"):
            reductions = float(arg)
        elif opt in ("-n", "--nThreads"):
            nThreads = int(arg)
        elif opt in ("-b", "--big"):
            big = int(arg)
        elif opt in ("-sd" , "--sched"):
            schedule = arg;


    noofInts= (workingset * 1024 *1024 ) / 4
    noofOperations= noofInts * 1000;
    innerItrSize = int( 100.00/ reductions)
    innerItrs = iterationsize/ innerItrSize
    reductionpercentage=  reductions
    reductions = (reductions * iterationsize)/100
    reductionops = ["+","^","||","&&","/","*","&","+","-"]
    p("/*********************************************")
    p("The main Program generated using openMPeigenbench v3 ")
    p("bench at " + str(datetime.now()))
    p("The for construct iteration size is" + str(iterationsize))
    p("wth percentage of reduction operations " + str(reductionpercentage))
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
    elif nThreads == 4 and big == 0:
        p("int cpunos[4]= {0,1,2,3};")
    elif nThreads == 2 and big == 2:
        p("int cpunos[2]= {4,5};")

    p("int main (int argc, char * argv[]){")
    p("     struct timeval start, end;")
    #p("float arr[NSIZE];")
    p("")
    p(" int i;")
    p(" omp_set_num_threads("+ str(nThreads) +");")
    #p("for(i=0;i<NSIZE;i++){")
    #p(" arr[i] = i;")
    #p("}")
    if schedule == "DYNAMIC":
        p("int scheddata[ NTHREADS*8];")
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
    p("printf(\"Percentage number of reductions is "+ str(reductionpercentage)+"\\n\");")
    p("printf(\"Total Instructions is "+ str(noofOperations)+"\");")
    p("   double time;\n gettimeofday(&start,(void*)0);")
    #p("energymonitor__startprofiling();\n");
    p("float reducedvalue = 0;")
    p(" # pragma omp parallel ")
    p("{")
    p("int tid = omp_get_thread_num();")
    p("  #pragma omp master ")
    p("{")
    p("printf(\"\\n\\n The number of Threads : %d\\n\",omp_get_num_threads());")
    p("}")
    #localbufsize = 256;
    #p("int local ["+str(localbufsize)+"];")
    p("float ops1[16],ops2;")

    if schedule == "DYNAMIC" :
        p("  cpu_set_t set;")
        p("CPU_ZERO(&set);")
        p("CPU_SET(cpunos[tid],&set);")
        p("int t = sched_setaffinity(syscall(SYS_gettid), sizeof(set), &set);")
        p("if(t == -1)")
        p("printf(\"Error in setting affinity\");")
        p(" # pragma omp for private(i) schedule(dynamic) reduction("+ reductionops[0]+":reducedvalue)")
    else:
        p("schedule should be dynamic")


    p("for (i=0;i<"+ str(parallel) +";i++){\n")
    p("scheddata[tid*8]++;");
    isize = int(iterationsize +  reductions)
    k = 0
    for num in range(0,isize):
        k = k + 1
        if k == 16:
            k = 0
        numb = int( np.random.uniform(0,isize))
        if numb < reductions:
            p("reducedvalue = reducedvalue "+ reductionops[0]+ "ops1["+str(k)+"];")
        else:
            if numb % 16 == 3:
                p("ops1["+str(k)+"] = ops1["+str(k)+"] / ops2;" )
            elif numb % 4 == 2:
                p("ops1["+str(k)+"] = ops1["+str(k)+"] * ops2;")
            elif numb %4 == 1:
                p("ops1["+str(k)+"] = ops1["+str(k)+"] - ops2;")
            elif numb % 16 == 7:
                p("ops2 = " +  str(np.random.uniform(0,iterationsize)) + ";")
            else:
                p("ops1["+str(k)+"] = ops1["+str(k)+"] + ops2;")

    p("}\n}")
    p("printf(\"End benchmark %f\\n\",reducedvalue);")
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
