#! /bin/bash

# $1 is the application

cd ../../apps/$1/pmcs

FOUND=`find */ -name pmcs_schedule.txt`
#rm */pmcs_schedule.txt

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

        if [ "$config" = "2b" ] || [ "$config" = "A72" ]
        then
                core_type="A72"
        fi


 	NL=$'\n'

        output=""
	echo $config
        if [ "$config" = "4l"  ] || [ "$config" = "A53" ]
        then
		output="5${NL}"
                output+="1 0x01,0x02,0x03,0x04,0x05,0x06${NL}"
                output+="2 0x07,0x08,0x0A,0x0C,0x0D,0x0F${NL}"
                output+="3 0x10,0x11,0x12,0x13,0x14,0x15${NL}"
                output+="4 0x16,0x17,0x18,0x19,0x1D,0x60${NL}"
                output+="5 0x61,0x7A,0x86,0x00,0x00,0x00${NL}"

        elif [ "$config" = "2b"  ] || [ "$config" = "A72"  ]
        then
		output="11${NL}"
               	output+="1 0x01,0x02,0x03,0x04,0x05,0x08${NL}"
                output+="2 0x09,0x10,0x11,0x12,0x13,0x14${NL}"
                output+="3 0x15,0x16,0x17,0x18,0x19,0x1B${NL}"
                output+="4 0x1D,0x40,0x41,0x42,0x43,0x46${NL}"
                output+="5 0x47,0x48,0x4C,0x4D,0x50,0x51${NL}"
                output+="6 0x52,0x53,0x56,0x58,0x60,0x61${NL}"
                output+="7 0x62,0x64,0x66,0x67,0x68,0x69${NL}"
                output+="8 0x6A,0x6C,0x6D,0x6E,0x70,0x71${NL}"
                output+="9 0x72,0x73,0x74,0x75,0x76,0x78${NL}"
                output+="10 0x79,0x7A,0x7C,0x7E,0x81,0x82${NL}"
        	output+="11 0x83,0x84,0x86,0x90,0x91,0x00${NL}"
        fi

        printf "$output" > $goto_dir"/pmcs_schedule.txt"



	cd $goto_dir
	#echo $PWD
	#ls -l .
	mv pmcs_schedule.txt ../../bin
	pmcs_dir=$PWD
	cd ../../bin
        if [ "$config" = "4l" ]
        then
                sudo taskset -a -c 0-3 ../../../data_collection/bin/scheduler_$core_type ./$bin_filename
		mv *.csv $pmcs_dir
		mv *.txt $pmcs_dir

        elif [ "$config" = "2b" ]
        then
                sudo taskset -a -c 4-5 ../../../data_collection/bin/scheduler_$core_type ./$bin_filename
		mv *.csv $pmcs_dir
		mv *.txt $pmcs_dir

        else
                sudo taskset -a -c 0-5 ../../../data_collection/bin/scheduler_$core_type ./$bin_filename
		mv *.csv $pmcs_dir
		mv *.txt $pmcs_dir

	fi
	cd $pmcs_dir
	cd ..

done
