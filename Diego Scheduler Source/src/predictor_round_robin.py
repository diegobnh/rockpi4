#!/usr/bin/env python3
import sys

actions = [3,5,13] # Theses numbers represent the states ["4l","2b","4l2b"]. See states.hpp
round_robin = itertools.cycle(seq)

def main():
 
    while True:
        L_pmu1_str, L_pmu2_str, L_pmu3_str, L_pmu4_str, L_pmu5_str, \
	B_pmu1_str, B_pmu2_str, B_pmu3_str, B_pmu4_str, B_pmu5_str,B_pmu6_str, B_pmu7_str, \
	cpu_migration_str, context_switch_str, cpu_usage_little_str, cpu_usage_big_str, state_str, exec_time_str = input().split() 
        
        print(round_robin.next()) 

if __name__ == "__main__":
    main()
