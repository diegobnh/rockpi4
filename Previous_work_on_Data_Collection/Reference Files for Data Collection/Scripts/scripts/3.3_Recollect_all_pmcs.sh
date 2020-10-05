#! /bin/bash

cd $BENCHMARK_PATH/pmcs
FOLDERS=`find */ -name pmcs_schedule.txt`  

for f in $FOLDERS
do
        folder_name=${f%/*}  

 	NL=$'\n'
        output=""
	output=$(cat $PMCS_FILE | wc -l)
        output+="${NL}"
        output+=$(cat $PMCS_FILE)

        printf "$output" > $folder_name"/pmcs_schedule.txt"

	cd $folder_name

	mv pmcs_schedule.txt $BENCHMARK_PATH/bin
	cd $BENCHMARK_PATH/bin

        $COLLECTOR_PATH/collector_pmcs_intel pmcs_schedule.txt ./$folder_name".sh"   #the name of binary folder

	mv *.csv $BENCHMARK_PATH/pmcs/$folder_name
	mv *.txt $BENCHMARK_PATH/pmcs/$folder_name

	cd ..

done
