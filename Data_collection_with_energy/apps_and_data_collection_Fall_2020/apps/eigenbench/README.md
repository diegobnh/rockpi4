An attempt to generate synthetic openmp with knobs controlling amount 
of parallel code, memory operations, CPU  operations and expected 
runtime (for a specifc cpu power).

The eigen properties handled:
# v1:  
concurrency (amount of serial/parallel) workload.
working-set size (shared memory size)
memory operations (amount of memory / cpu operations)
temporal locality (randomization)
# v2:
system calls
iteration size
loop scheduling and 
loop size
# v3   
Reductions
atomics
critical

# v4  
Falsesharing 
Memory density






# Contact
Jyothi Krishna V S, IIT Madras <jkrishna@cse.iitm.ac.in>  
Rupesh Nasre, IIT Madras <rupesh@cse.iitm.ac.in>  
Shankar Balachandran <shankar.sb@gmail.com>

