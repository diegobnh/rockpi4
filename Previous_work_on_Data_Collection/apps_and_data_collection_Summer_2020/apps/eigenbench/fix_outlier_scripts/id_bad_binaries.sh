#! /bin/bash

cd /home/rock/rockpi4/benchmarks/eigenbench/pmcs

FOLDERS=`ls -d */`

for entry in $FOLDERS
do
	cd $entry
	num_csv=`ls -l *.csv | grep -v ^l | wc -l`

	if [[ "$num_csv" != "5"  ]] && [[ "$num_csv" != "11"  ]]
	then
		echo $entry": incorrect number of csv files"
	fi

	min_cols=`cat *.csv | awk -F, "{print NF}" | datamash min 1`
	max_cols=`cat *.csv | awk -F, "{print NF}" | datamash max 1`

	if [[ "$max_cols" != "$min_cols"  ]]
	then
		echo $entry": incorrect number of columns"
	fi

	num_empty_csv=`find . -name "*.csv" -type f -empty | wc -l`
	num_empty_other=`find . \( ! -name "*.csv" \) -type f -empty | wc -l`

	if [[ "$num_empty_csv" != "0" ]]
	then
		echo $entry": has empty csv file(s)"
	fi

	if [[ "$num_empty_other" != "0"  ]]
	then
		echo $entry": has empty file(s) that are not csv"
	fi

	#Checking if the correct csv files are there
	parsed=()
	for i in $(echo $entry | tr "_" "\n")
	do
		parsed+=( $i )
	done

	config_type=""

	if [[ "${#parsed[@]}" = "4" ]]
	then
		config_type="${parsed[0]}"
	else
		if [[ "${parsed[1]}" = "A53"  ]]
		then
			config_type="4l"
		else
			config_type="2b"
		fi
	fi

	if [[ ! -f "0x01_0x02_0x03_0x04_0x05_0x06.csv" ]] || \
	   [[ ! -f "0x07_0x08_0x0A_0x0C_0x0D_0x0F.csv" ]] || \
	   [[ ! -f "0x10_0x11_0x12_0x13_0x14_0x15.csv" ]] || \
	   [[ ! -f "0x16_0x17_0x18_0x19_0x1D_0x60.csv" ]] || \
	   [[ ! -f "0x61_0x7A_0x86_0x00_0x00_0x00.csv" ]] && \
	   [[ "$config_type" = "4l"  ]]
	then
		echo $entry": missing csv file(s) or contains incorrect csv file(s)"
	fi

        if [[ ! -f "0x01_0x02_0x03_0x04_0x05_0x08.csv" ]] || \
           [[ ! -f "0x09_0x10_0x11_0x12_0x13_0x14.csv" ]] || \
           [[ ! -f "0x15_0x16_0x17_0x18_0x19_0x1B.csv" ]] || \
           [[ ! -f "0x1D_0x40_0x41_0x42_0x43_0x46.csv" ]] || \
           [[ ! -f "0x47_0x48_0x4C_0x4D_0x50_0x51.csv" ]] || \
	   [[ ! -f "0x52_0x53_0x56_0x58_0x60_0x61.csv" ]] || \
           [[ ! -f "0x62_0x64_0x66_0x67_0x68_0x69.csv" ]] || \
           [[ ! -f "0x6A_0x6C_0x6D_0x6E_0x70_0x71.csv" ]] || \
           [[ ! -f "0x72_0x73_0x74_0x75_0x76_0x78.csv" ]] || \
           [[ ! -f "0x79_0x7A_0x7C_0x7E_0x81_0x82.csv" ]] || \
	   [[ ! -f "0x83_0x84_0x86_0x90_0x91_0x00.csv" ]] && \
           [[ "$config_type" = "2b"  ]]
        then
               echo $entry": missing csv file(s) or contains incorrect csv file(s)"
        fi


	cd ..
done
