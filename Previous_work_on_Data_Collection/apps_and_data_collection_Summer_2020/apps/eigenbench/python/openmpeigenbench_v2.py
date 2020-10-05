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
    # parser = argparse.ArgumentParser()
    # parser.parse_args()
    # parser.add_argument("--file")
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
    # Expected  concurrency
    # can vary from 0 to 1
    # we are looking for 
    concurrency  = 1.0
    # here we will look into the effect of unknown functions
    # or system calls in operations.
    # it can vary to upto 0 - 0.4
    # we should give only 0, 0.1,0.2,0.25, 0.4 
    systemcalls  = 0.1

    # length of the for iteratoin this will vary from 1
    # to 1000
    iterationsize = 1;
    #This will a flag that decides if we want to have a loop
    #inside the for construct
    loop = 1
    # scheduling static or dynamic 
    schedule =  "DYNAMIC" 
    try:
        opts, args = getopt.getopt(argv,"hu:i:l:",["sys=","iter=","loop=", "sched="])
    except getopt.GetoptError:
        print 
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'openmpeigenbench_v2.py -u <systemcalls> -i <itersize> -l <YES/NO> -sd <STATIC/DYNAMIC>'
            sys.exit()
        elif opt in ("-u", "--sys"):
            systemcalls = float(arg)
        elif opt in ("-i", "--iter"):
            iterationsize = int(arg)
        elif opt in ("-l","--loop"):
            if arg == "YES":
                loop = 1
            else:
                loop = 0
        elif opt in ("-sd" , "--sched"):
            schedule = arg;


    noofInts= (workingset * 1024 *1024 ) / 4
    noofOperations= noofInts *800;
    systemcalllist = ["sqrt","sin","cos","cosh","sinh","tan","tanh","log","exp"]
    p("/*********************************************")
    p("The main Program generated using openMPeigenbench v2 ") 
    p("bench at " + str(datetime.now()))
    p("The percentage of sys calls is" + str(systemcalls * 100))
    p("The for construct iteration size is" + str(iterationsize))
    if loop == 1:
        p("realized with a loop inside for construct")
    else:
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
    p("for(i=0;i<NSIZE;i++){")
    p(" arr[i] = i;")
    p("}")
    if schedule == "DYNAMIC":
        p("int scheddata[ NTHREADS];")
        p("for(i=0;i<NTHREADS;i++)")
        p("scheddata[i] = 0;")
    p("int syscalls = " + str(int(systemcalls*100)) + ";")
    # serial=int((noofOperations*(1.0 - concurrency))/((1.0-concurrency) + (nThreads*concurrency))) 
    # parallel = noofOperations - serial;
    # serialrand =  randint(0,10000)
    # p("int s_rand = "+ str(serialrand) + ";")

    parallel = noofOperations / iterationsize

    p("int p_rand["+ str(nThreads) +"];")
    for num in range (0,nThreads):
        prand = randint(0,10000)
        p("p_rand["+ str(num) +"] = " + str(prand) +";")
#    p("int oper = " + str(noofOperations) +";")
    p("energymonitor__saveastextfile(\"prof.txt\");\nenergymonitor__trackpoweronly();\n")
    p("int cores = 255;\n energymonitor__init(cores, 0.1);\n ")
    p("printf(\"Begin benchmark\\n\");")
    p("   double time;\n gettimeofday(&start,(void*)0);")
    
    # serial region of the code
    # p(" int j;")
    # p("for (i=0;i<"+ str(serial) +";i++){\n")
    # if(temporallocality == 1):
    #     p("j = i%NSIZE;")
    # else:
    #     p("j = rand_r(&s_rand)%NSIZE")
    # p("if(rand_r(&s_rand)%100 < oper)")
    # p("   arr[j] =  rand_r(&s_rand);")
    # p("else")
    # p("   arr[j] =  arr[j] + arr[j-1]+ arr[j+1];")
    # p("}\n")
 
   #parallel region of the code
    # p(" # pragma omp parallel ")
    # p("{")
    # p("int tid = omp_get_thread_num();")
    # p(" # pragma omp for private(i,j) ")
    # p("for (i=0;i<"+ str(parallel) +";i++){\n")
    # if(temporallocality == 1):
    #     p("j = i%NSIZE;")
    # else:
    #     p("j = (rand_r(&p_rand[tid])%NSIZE;")
    #     p("j += tid - j%NTHREADS;")
    # p("if(rand_r(&p_rand[tid])%100 < oper)")
    # p("   arr[j] =  rand_r(&p_rand[tid]);")
    # p("else")
    # p("   arr[j] =  arr[j] + arr[j-1]+ arr[j+1];")
    # p("}")
    # p("}")

    # parallel region for v2
    p("energymonitor__startprofiling();\n");
    p(" # pragma omp parallel ")
    p("{")
    p("int tid = omp_get_thread_num();")
    p("int k = (NSIZE/NTHREADS)*tid;")
    if schedule == "DYNAMIC" :
        p("  cpu_set_t set;")
        p("CPU_ZERO(&set);")
        p("CPU_SET(tid,&set);")
        p("int t = sched_setaffinity(syscall(SYS_gettid), sizeof(set), &set);")
        p("if(t == -1)")
        p("printf(\"Error in setting affinity\");")
        p(" # pragma omp for private(i)  schedule(dynamic) nowait")
    else :
        p(" # pragma omp for private(i) schedule(static) nowait")
    p("for (i=0;i<"+ str(parallel) +";i++){\n")
    p("scheddata[tid]++;")
    p("if (k >= (NSIZE/NTHREADS)*tid + 1)")
    p("       k = (NSIZE/NTHREADS)*tid;")
    p("k++;")
    if loop == 1 :
        nosyscalls = 1
        if systemcalls == 0:
            loopsize  = 1
            nosyscalls = 0
        elif systemcalls == 0.1:
            loopsize = 10
        elif systemcalls == 0.2:
            loopsize = 5
        elif systemcalls == 0.25:
            loopsize  = 4
        elif systemcalls == 0.3:
            loopsize = 10
            nosyscalls = 3
        elif systemcalls == 0.4:
            loopsize = 5
            nosyscalls = 2
        else: 
           p("fprintf(stderr,\"The amount of system calls was unexpected "+str(systemcalls)+"\");")
           p("exit(0);")
        itrs = float(iterationsize)/loopsize
        if itrs.is_integer():
            p("int j;")
            p("for(j=0;j<" + str(loopsize)+ "; j++){")
            if np.random.uniform(0,loopsize) < nosyscalls :
                p("arr[k] = " + systemcalllist[randint(0,len(systemcalllist)-1)] + "(arr[k]);")
            else:
                p("arr[k] += 2 + arr[k-1] + arr[k+1];")
            p("}")
        else:
            scalls = systemcalls * iterationsize
            for num in range(0,iterationsize):
                if np.random.uniform(0,iterationsize) < scalls:
                    p("arr[k] = " + systemcalllist[randint(0,len(systemcalllist)-1)] + "(arr[k]);")
                else:
                    p("arr[k] += 2 + arr[k-1] + arr[k+1];")
    else:
        scalls = systemcalls * iterationsize
        for num in range(0,iterationsize):
            if np.random.uniform(0,iterationsize) < scalls:
                p("arr[k] = " + systemcalllist[randint(0,len(systemcalllist)-1)] + "(arr[k]);")
            else:
                p("arr[k] += 2 + arr[k-1] + arr[k+1];")            
    p("}")
    p("}")
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
