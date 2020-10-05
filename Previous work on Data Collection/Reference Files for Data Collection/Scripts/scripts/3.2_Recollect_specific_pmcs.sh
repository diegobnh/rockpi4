#! /bin/bash

#Look at the outliers.txt file in outliers folder

#Step 1: Parse the lines from outliers.txt for directory and line number(s)
#Step 2: Run the relevant binary while collecting the relevant PMCs

cd $BENCHMARK_PATH/pmcs
rm -f */pmcs_schedule.txt

#After you run this part, just those folder that have pmcs_schedule will be collect again! Its like an signal which application has outliers!!!
cat $BENCHMARK_PATH/outlier/outliers.txt | while read LINE
do

	#Step 1
	parsed_outlier=()
	for entry in $(echo $LINE | tr " " "\n")
	do
		parsed_outlier+=( $entry )
	done
	app_folder_name=${parsed_outlier[0]}

	lines_to_recollect=()
	for entry in "${parsed_outlier[@]}"
	do
		if [ "$entry" != "$app_folder_name" ]
		then
			lines_to_recollect+=( $entry )
		fi
	done

	NL=$'\n'
	output="${#lines_to_recollect[@]}${NL}"
	for i in "${lines_to_recollect[@]}"
	do
        	output+=$(cat $PMCS_FILE | awk -v line="$i" 'NR==line{print $0}')
	        output+="${NL}"
	done

	printf "$output" > $app_folder_name/"pmcs_schedule.txt"
done




cd $BENCHMARK_PATH/pmcs

FOLDERS=`find */ -name pmcs_schedule.txt`  #get list of folder + pmcs_schedule.txt that exist inside this file "pmcs_schedule"

for folder_name in $FOLDERS
do
        folder_name=${folder_name%/*}  #remove the pmcs_schedule in name of variable
        cd $folder_name
	mv pmcs_schedule.txt $BENCHMARK_PATH/bin

	#Save the old executin time and replace only the line that exist outliers
	old_times=()
	cat ExecutionTimes.txt | (while read entry
	do
		old_times+=( $entry )
	done

	lines_to_recollect=()
	cat $BENCHMARK_PATH/outlier/outliers.txt | (while read LINE
	do
		parsed_outlier=()
       		for entry in $(echo $LINE | tr " " "\n")
        	do
               		parsed_outlier+=( $entry )
        	done

		folders=${parsed_outlier[0]}

        	for entry in "${parsed_outlier[@]}"
        	do
                	if [ "$entry" != "$folders" ] && [ "$folders" = "$folder_name/" ]
                	then
                        	lines_to_recollect+=( $entry )  #get line number of outliers
                	fi
        	done
	done

        #Run again the application with outlier and get a new Execution Time File
        cd $BENCHMARK_PATH/bin

        sudo $COLLECTOR_PATH/collector_pmcs_intel pmcs_schedule.txt ./$folder_name".sh"   #the name of binary folder

	mv *.csv $BENCHMARK_PATH/pmcs/$folder_name
	mv *.txt $BENCHMARK_PATH/pmcs/$folder_name

        cd $BENCHMARK_PATH/pmcs/$folder_name

        #Now merge old time with new specific time for outliers
	new_times=()
	cat ExecutionTimes.txt | (while read entry
	do
		new_times+=( $entry )
	done

	for i in "${lines_to_recollect[@]}"
	do
		for j in "${new_times[@]}"
		do
			let "index=$i-1"
			old_times[$index]=$j
		done
	done

	NL=$'\n'

	rm ExecutionTimes.txt

	output=""
	for i in "${old_times[@]}"
	do
		output+="$i${NL}" 
	done

	printf "$output" > ExecutionTimes.txt

	)))   #close all whiles 

	cd ..

done
