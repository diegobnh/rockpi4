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
    noofOperations = noofInts *600;
    iterationsize = 8192
    percentagecritical = critical
    critical = int((critical * iterationsize) / 100)
    p("/*********************************************")
    print critical
    print noofOperations
    print percentagecritical
    p("The main Program generated using openMPeigenbench v3 ") 
    p("bench at " + str(datetime.now()))
    p("The for construct iteration size is" + str(iterationsize))
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
    p("#include \"energylib.h\"")
    p("#define NSIZE "+ str(noofInts))
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
    parallel = noofOperations / iterationsize
    p("int p_rand["+ str(nThreads) +"];")
    for num in range (0,nThreads):
        prand = randint(0,10000)
        p("p_rand["+ str(num) +"] = " + str(prand) +";")
    p(" energymonitor__saveastextfile(\"prof.txt\"); \nenergymonitor__trackpoweronly();\n");
    p("int cores = 255;\n energymonitor__init(cores, 0.1);\n ")
    p("printf(\"Begin benchmark\\n\");")
    p("printf(\"percentage of operations in critical section is "+str(percentagecritical)+"\\n\");")
    p("printf(\"Total Instructions is "+ str(noofOperations)+"\");")
    p("   double time;\n gettimeofday(&start,(void*)0);")
    p("energymonitor__startprofiling();\n");
    p(" # pragma omp parallel ")
    p("{")
    p("int tid = omp_get_thread_num();")
    p("  #pragma omp master ")
    p("{")
    p("printf(\"\\n\\n The number of Threads : %d\\n\",omp_get_num_threads());")
    p("}")
    p("int k = (NSIZE/NTHREADS)*tid;")
    p("float op1, op2;")
    if schedule == "DYNAMIC" :
        p("  cpu_set_t set;")
        p("CPU_ZERO(&set);")
        p("CPU_SET(cpunos[tid],&set);")
        p("int t = sched_setaffinity(syscall(SYS_gettid), sizeof(set), &set);")
        p("if(t == -1)")
        p("printf(\"Error in setting affinity\");")
        p(" # pragma omp for private(i) schedule(dynamic)")
    p("for (i=0;i<"+ str(parallel) +";i++){\n")
    p("scheddata[tid*8]++;");
    localbufsize = 256;
#    p("int local ["+str(localbufsize)+"];")
    p("k = i%NSIZE;")
    skip = 0
#    p("// totalcritical " + str(critical))
    for num in range(0,iterationsize): 
        if skip == 0:
            criticalsize = int(np.random.uniform(0,iterationsize)) 
            if criticalsize < critical: 
 #               p("// num " + str(num) + " gencritic " + str(critical) + " criticalsize " + str(criticalsize) )
                p("#pragma omp critical")
                p("{")
                for cr in range(0,int(criticalsize)):
                    if cr %2 ==1 :
                        p("shared -= op1;")
                    else :
                        p("shared += op2;")
                p("}")
                skip = criticalsize
                critical = critical - criticalsize
            else: 
                if criticalsize%8 == 7:
                    p("op1 = op1 * op2;")
                elif criticalsize%4 == 2:
                    p("op1 = op1 * op2; ")
                elif criticalsize%4 == 1:
                    p("op1 = op1 - op2; ")
                else :
                    p("op1 = op1 + op2; ")
  #              p("// num " + str(num))
#                p("local["+ str(int(np.random.uniform(0,localbufsize))) + "] += 2 + local[" + str(int(np.random.uniform(0,localbufsize))) + "] + local["+ str(int(np.random.uniform(0,localbufsize))) +"];")
        else:
   #         p("// num " + str(num) + " skip " + str(skip))
            skip = skip -1
            

    p("}\n}")
    p("printf(\"End benchmark %f\\n\",shared);")
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
