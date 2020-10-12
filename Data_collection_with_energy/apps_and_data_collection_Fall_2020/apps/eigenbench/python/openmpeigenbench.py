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
    try:
        opts, args = getopt.getopt(argv,"hc:m:",["con=","mem="])
    except getopt.GetoptError:
        print 'openmpeigenbench.py -c <concurrency> -m <memoryoperations>'
        sys.exit(2)
    for opt, arg in opts:
        if opt == '-h':
            print 'openmpeigenbench.py -c <concurrency> -m <memoryoperations>'
            sys.exit()
        elif opt in ("-c", "--con"):
            concurrency = float(arg)
        elif opt in ("-m", "--mem"):
            memoryoperations = float(arg)  
    noofInts= (workingset * 1024 *1024 ) / 4
    p("/*********************************************")
    p("The main Program generated using openMPeigen ") 
    p("bench at " + str(datetime.now()))
    p("*********************************************/")
    p("#include <stdio.h>")
    p("#include <omp.h>")
    p("#include <stdlib.h>")
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

    noofOperations= noofInts *50;
    serial=int((noofOperations*(1.0 - concurrency))/((1.0-concurrency) + (nThreads*concurrency))) 
    parallel = noofOperations - serial;
    serialrand =  randint(0,10000)
    p("int s_rand = "+ str(serialrand) + ";")
    p("int p_rand["+ str(nThreads) +"];")
    for num in range (0,nThreads):
        prand = randint(0,10000)
        p("p_rand["+ str(num) +"] = " + str(prand) +";")
    p("int oper = " + str(memoryoperations * 100) +";")

    p("int cores = 255;\n energymonitor__saveastextfile(\"prof.txt\");\n energymonitor__trackpoweronly();\n");
    p("energymonitor__init(cores,0.1); energymonitor__startprofiling();\n");
    p("printf(\"Begin benchmark\\n\");")
    p("   double time;\n gettimeofday(&start,(void*)0);")
    # serial region of the code
    p(" int j;")
    p("for (i=0;i<"+ str(serial) +";i++){\n")
    if(temporallocality == 1):
        p("j = i%NSIZE;")
    else:
        p("j = rand_r(&s_rand)%NSIZE")
    p("if(rand_r(&s_rand)%100 < oper)")
    p("   arr[j] =  rand_r(&s_rand);")
    p("else")
    p("   arr[j] =  arr[j] + arr[j-1]+ arr[j+1];")
    p("}\n")
    #parallel region of the code
    p(" # pragma omp parallel ")
    p("{")
    p("int tid = omp_get_thread_num();")
    p(" # pragma omp for private(i,j) ")
    p("for (i=0;i<"+ str(parallel) +";i++){\n")
    if(temporallocality == 1):
        p("j = i%NSIZE;")
    else:
        p("j = (rand_r(&p_rand[tid])%NSIZE;")
        p("j += tid - j%NTHREADS;")
    p("if(rand_r(&p_rand[tid])%100 < oper)")
    p("   arr[j] =  rand_r(&p_rand[tid]);")
    p("else")
    p("   arr[j] =  arr[j] + arr[j-1]+ arr[j+1];")
    p("}")
    p("}")
    p("printf(\"End benchmark %d\\n\",arr[1]);")
    p("     gettimeofday(&end,(void*)0);\n energymonitor__stopprofiling();") 
    p("time = (double)(end.tv_sec - start.tv_sec) + (1.0e-6*(end.tv_usec - start.tv_usec));")
    p("printf(\"Elapsed time in seconds =  %f \\n\", time);\n")
    p("return 0;")
    p("}")
if __name__  == "__main__" : 
    main(sys.argv[1:])
