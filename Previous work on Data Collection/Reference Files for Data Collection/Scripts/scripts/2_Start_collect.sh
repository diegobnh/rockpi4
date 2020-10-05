#! /bin/bash

NUM_ITERATIONS=3

for ((i=0 ; i< $(nproc); i++)); 
do
  echo performance > /sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor;
done

cd $BENCHMARK_PATH/bin
NL=$'\n'
pmcs=$(cat $PMCS_FILE | wc -l)
pmcs+="${NL}"
pmcs+=$(cat $PMCS_FILE)

printf "$pmcs" > pmcs_schedule.txt  #this file will be used for all applications


files=`ls *.sh`
for file in $files;
do
  filename=$(echo "$file" | cut -f 1 -d '.')
  #n_cpus=$((nproc -1))

  if [ $FLAG_DRAM == 'True' ]; then 
	sudo $COLLECTOR_PATH/./collector_pmcs_intel pmcs_schedule.txt ./$file #/$file > /dev/null
  fi

  
  #sudo perf stat -I 200 -a -C 24-47 -o ${FOLDERS_NAME[$j]}"_"$i".perf" ${PERF_PMCS[$i]} hwloc-bind socket=1 --membind node=2 ${APPS[$j]} 
  if [ $FLAG_PMEM == 'True' ]; then 
        for ((i=0 ; i< $NUM_ITERATIONS; i++)); 
        do
		sudo $COLLECTOR_PATH/./collector_pmcs_intel pmcs_schedule.txt ./$file #/$file > /dev/null
		mv ExecutionTimes.txt ExecutionTimes_$i.txt 
        done
	
  fi

  mkdir -p $BENCHMARK_PATH/pmcs/"${filename}"
  mv *.csv $BENCHMARK_PATH/pmcs/"${filename}"
  mv ExecutionTimes* $BENCHMARK_PATH/pmcs/"${filename}"
  cp pmcs_schedule.txt $BENCHMARK_PATH/pmcs/"${filename}"

  sleep 10
done

cd $DATA_COLLECTION_PATH/scripts
