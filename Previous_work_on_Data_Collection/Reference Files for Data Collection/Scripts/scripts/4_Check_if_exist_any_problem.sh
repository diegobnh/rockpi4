#! /bin/bash

TOTAL_FILES_PMCS=$(wc -l $PMCS_FILE | awk '{print $1}')


cd $BENCHMARK_PATH/pmcs
FOLDERS=`ls -d */`

for folder in $FOLDERS
do
	cd $folder
	num_csv=`ls -l *.csv | grep -v ^l | wc -l`

        #check number of files - in little case is 5, in big case is 11
	if [[ "$num_csv" != "$TOTAL_FILES_PMCS" ]]
	then
		echo $folder": incorrect number of csv files"
	fi

        #check number of columns
	min_cols=`cat *.csv | awk -F, "{print NF}" | datamash min 1`
	max_cols=`cat *.csv | awk -F, "{print NF}" | datamash max 1`

	if [[ "$max_cols" != "$min_cols"  ]]
	then
		echo $folder": incorrect number of columns"
	fi

        #check if exist file empty
	num_empty_csv=`find . -name "*.csv" -type f -empty | wc -l`
	num_empty_other=`find . \( ! -name "*.csv" \) -type f -empty | wc -l`

	if [[ "$num_empty_csv" != "0" ]]
	then
		echo $folder": has empty csv file(s)"
	fi

	if [[ "$num_empty_other" != "0"  ]]
	then
		echo $folder": has empty file(s) that are not csv"
	fi        

	cd ..
done

cd $DATA_COLLECTION_PATH/scripts
