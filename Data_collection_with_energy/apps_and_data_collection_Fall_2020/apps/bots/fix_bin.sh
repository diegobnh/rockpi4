#! /bin/bash

#export OMP_NUM_THREADS=4
APP_COMMANDS=("fib.gcc.omp-tasks-tied -o 0 -n 32" \
              "nqueens.gcc.omp-tasks-tied -n 12" \
              "health.gcc.omp-tasks-tied -o 0 -f ../inputs/health/medium.input" \
              "floorplan.gcc.omp-tasks-tied -o 0 -f ../inputs/floorplan/input.15" \
              "fft.gcc.omp-tasks-tied -o 0 -n 1000000" \
              "sort.gcc.omp-tasks-tied -o 0 -n 100000000" \
              "sparselu.gcc.for-omp-tasks-tied -o 0 -n 75 -m 75" \
              "strassen.gcc.omp-tasks-tied -o 0 -n 4096")

APP_NAMES=("fib" "nqueens" "health" "floorplan" "fft" "sort" "sparselu" "strassen")
CONFIG_LIST=("n4b0" "n2b2" "n6b2")

NL=$'\n'
#mv bin original_bin
#mkdir bin
#cd bin
for((k = 0; k< ${#APP_COMMANDS[@]}; k++));
do
	#output=""
	output=$'#! /bin/bash\n'
	#output=$'cd ../original_bin\n'
	output+="./../original_bin/${APP_COMMANDS[$k]}"
	echo "$output"
	echo "---------------------"
	for((i = 0; i< ${#CONFIG_LIST[@]}; i++));
	do
		#Only works because app_commands and app_names are the same length
		filename=${APP_NAMES[$k]}"_"${CONFIG_LIST[$i]}
		echo $filename
		echo "$output" > $filename
		chmod 755 $filename
        	mv $filename bin
	done

done
