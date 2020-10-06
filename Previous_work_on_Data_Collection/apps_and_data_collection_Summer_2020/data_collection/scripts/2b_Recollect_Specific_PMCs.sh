#! /bin/bash

#Look at the outliers.txt file.
#Each line follows the following format

#<directory> <line number> [<line number> ...]

#Each directory follows the following format

#<cluster config>_<binary directory>_<binary file name>_pmcs/
#OR
#<cluster config>_<core type>_<binary directory>_<binary file name>_pmcs/

#Each line number ranges from 1 to 11.

#Each number corresponds to a set of six PMCs depending on the what
#  cluster configuration/core type. These specific PMCs are outlined
#  in Diego's scheduler code.

#For the 4l cluster configuration or the A53 core type, the order of
#collection is as follows:
#  1: 0x01_0x02_0x03_0x04_0x05_0x06
#  2: 0x07_0x08_0x0A_0x0C_0x0D_0x0F
#  3: 0x10_0x11_0x12_0x13_0x14_0x15
#  4: 0x16_0x17_0x18_0x19_0x1D_0x60
#  5: 0x61_0x7A_0x86_0x00_0x00_0x00


#For the 2b cluster configuration or the A72 core type, the order of
#collection is as follows:
#  1: 0x01_0x02_0x03_0x04_0x05_0x08
#  2: 0x09_0x10_0x11_0x12_0x13_0x14
#  3: 0x15_0x16_0x17_0x18_0x19_0x1B
#  4: 0x1D_0x40_0x41_0x42_0x43_0x46
#  5: 0x47_0x48_0x4C_0x4D_0x50_0x51
#  6: 0x52_0x53_0x56_0x58_0x60_0x61
#  7: 0x62_0x64_0x66_0x67_0x68_0x69
#  8: 0x6A_0x6C_0x6D_0x6E_0x70_0x71
#  9: 0x72_0x73_0x74_0x75_0x76_0x78
# 10: 0x79_0x7A_0x7C_0x7E_0x81_0x82
# 11: 0x83_0x84_0x86_0x90_0x91_0x00


#Step 1: Parse the lines from outliers.txt for directory and line number(s)
#Step 2: Parse the directory for all information listed above
#Step 3: Run the relevant binary whilst collecting the relevant PMCs

cd "$APP_PMC_DIR"
rm */pmcs_schedule.txt

cat $APP_OUT_DIR/outliers.txt | while read LINE
do

	#Step 1
	parsed_outlier=()
	for entry in $(echo $LINE | tr " " "\n")
	do
		parsed_outlier+=( $entry )
	done

	dir=${parsed_outlier[0]}

	nums=()
	for entry in "${parsed_outlier[@]}"
	do
		if [ "$entry" != "$dir" ]
		then
			nums+=( $entry )
		fi
	done

	#Step 2
	init_bin_info=()
	for entry in $(echo $dir | tr "_" "\n")
	do
		if [ "$entry" != "pmcs/" ]
		then
			init_bin_info+=( $entry )
		fi
	done

	length=${#init_bin_info[@]}

	bin_info=()
	for entry in "${init_bin_info[@]}"
	do
		if [ "$entry" != "4l2b" ]
		then
			bin_info+=( $entry )
		fi
	done

	config=${bin_info[0]}
	bin_dir=${bin_info[1]}
	bin_filename=${bin_info[2]}

	#Modified Step 3
	#Output the proper information to a file that Diego's schedulers can use

	NL=$'\n'

	output="${#nums[@]}${NL}"
	core_type="A72"

	for i in "${nums[@]}"
	do
		if [ "$config" = "4l"  ] || [ "$config" = "A53" ]
		then
			core_type="A53"

			if [ "$i" = "1" ]
			then
				output+="1 0x01,0x02,0x03,0x04,0x05,0x06${NL}"

			elif [ "$i" = "2" ]
			then
				output+="2 0x07,0x08,0x0A,0x0C,0x0D,0x0F${NL}"

			elif [ "$i" = "3" ]
                        then
				output+="3 0x10,0x11,0x12,0x13,0x14,0x15${NL}"

			elif [ "$i" = "4" ]
                        then
				output+="4 0x16,0x17,0x18,0x19,0x1D,0x60${NL}"

			elif [ "$i" = "5" ]
                        then
				output+="5 0x61,0x7A,0x86,0x00,0x00,0x00${NL}"
			fi

		elif [ "$config" = "2b"  ] || [ "$config" = "A72"  ]
		then
			if [ "$i" = "1" ]
                        then
				output+="1 0x01,0x02,0x03,0x04,0x05,0x08${NL}"

			elif [ "$i" = "2" ]
                        then
				output+="2 0x09,0x10,0x11,0x12,0x13,0x14${NL}"

                        elif [ "$i" = "3" ]
                        then
				output+="3 0x15,0x16,0x17,0x18,0x19,0x1B${NL}"

                        elif [ "$i" = "4" ]
                        then
				output+="4 0x1D,0x40,0x41,0x42,0x43,0x46${NL}"

                        elif [ "$i" = "5" ]
                        then
				output+="5 0x47,0x48,0x4C,0x4D,0x50,0x51${NL}"

			elif [ "$i" = "6" ]
                        then
				output+="6 0x52,0x53,0x56,0x58,0x60,0x61${NL}"

                        elif [ "$i" = "7" ]
                        then
				output+="7 0x62,0x64,0x66,0x67,0x68,0x69${NL}"

                        elif [ "$i" = "8" ]
                        then
				output+="8 0x6A,0x6C,0x6D,0x6E,0x70,0x71${NL}"

                        elif [ "$i" = "9" ]
                        then
				output+="9 0x72,0x73,0x74,0x75,0x76,0x78${NL}"

                        elif [ "$i" = "10" ]
                        then
				output+="10 0x79,0x7A,0x7C,0x7E,0x81,0x82${NL}"

			elif [ "$i" = "11" ]
			then
				output+="11 0x83,0x84,0x86,0x90,0x91,0x00${NL}"
			fi
		fi
	done

	printf "$output" > $dir"pmcs_schedule.txt"
done

#Step 3 ... not quite sure how to do that yet ...

#The bin_filename variable is the binary of one microbenchmark

#The config variable is either 4l, 2b, A53, or A72
#  if config is A53 or A72 then the cluster config is 4l2b

#The nums array variable contains the line numbers that
#  correspond to the specific pmcs that need to be recollected
#  based on the config variable


#PROBLEMS:
#  1. How do I collect a specific set of 6 pmcs?

#PWD is apps_and_data_collection/apps/$1/pmcs

FOUND=`find */ -name pmcs_schedule.txt`

for entry in $FOUND
do
        goto_dir=${entry%/*}

	#NEED TO REPARSE: core_type, config, bin_dir, bin_filename
	init_bin_info=()
        for entry in $(echo $goto_dir | tr "_" "\n")
        do
                if [ "$entry" != "pmcs/" ]
                then
                        init_bin_info+=( $entry )
                fi
        done

        bin_info=()
        for entry in "${init_bin_info[@]}"
        do
                if [ "$entry" != "4l2b" ]
                then
                        bin_info+=( $entry )
                fi
        done

        config=${bin_info[0]}
        bin_dir=${bin_info[1]}
        bin_filename=$bin_dir"_"${bin_info[2]}

	core_type="A53"
	if [ "$config" = "2b" ] || [ "$config" = "A72" ]
	then
		core_type="A72"
	fi

	cd $APP_PMC_DIR"/"$goto_dir
	mv pmcs_schedule.txt $APP_BIN_DIR
	#Need to replace old ExecutionTimes with the new ones
	#so we need to store the old ones programatically

	#Each line number - 1 is the proper index of old_times
	#variable
	old_times=()
	cat ExecutionTimes.txt | (while read entry
	do
		old_times+=( $entry )
	done

	#Need to know the line numbers to replace in the old
	#ExecutionTimes.txt file
	nums=()
	cat $APP_OUT_DIR/outliers.txt | (while read LINE
	do
		parsed_outlier=()
       		for entry in $(echo $LINE | tr " " "\n")
        	do
               		parsed_outlier+=( $entry )
        	done

		dir=${parsed_outlier[0]}

        	for entry in "${parsed_outlier[@]}"
        	do
                	if [ "$entry" != "$dir" ] && [ "$dir" = "$goto_dir/" ]
                	then
                        	nums+=( $entry )
                	fi
        	done
	done


	#pmcs_dir=$PWD
        cd $APP_BIN_DIR
	#echo "Current directory: "$PWD
	if [ "$config" = "4l" ]
	then
    		sudo taskset -a -c 0-3 $COLLECTOR_PATH/scheduler_$core_type ./$bin_filename
		mv *.csv $APP_PMC_DIR"/"$goto_dir
		mv *.txt $APP_PMC_DIR"/"$goto_dir

	elif [ "$config" = "2b" ]
	then
    		sudo taskset -a -c 4-5 $COLLECTOR_PATH/scheduler_$core_type ./$bin_filename
		mv *.csv $APP_PMC_DIR"/"$goto_dir
		mv *.txt $APP_PMC_DIR"/"$goto_dir
	else
    		sudo taskset -a -c 0-5 $COLLECTOR_PATH/scheduler_$core_type ./$bin_filename
		mv *.csv $APP_PMC_DIR"/"$goto_dir
		mv *.txt $APP_PMC_DIR"/"$goto_dir
	fi
        cd $APP_PMC_DIR"/"$goto_dir
	#Read in the new ExecutionTimes
	#Each line number - 1 is a proper index in the
	#new_times variable
	new_times=()
	cat ExecutionTimes.txt | (while read entry
	do
		new_times+=( $entry )
	done

	count=0
	for i in "${nums[@]}"
	do
		let "index=$i-1"
    old_times[$index]=${new_times[$count]}
    let "count=$count+1"
	done

	NL=$'\n'

	rm ExecutionTimes.txt

	output=""
	for i in "${old_times[@]}"
	do
		output+="$i${NL}"
	done

	printf "$output" > ExecutionTimes.txt

	)))

	cd ..

done
