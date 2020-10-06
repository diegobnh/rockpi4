#! /bin/bash

# $1 is the application
# $2 is the number of iterations

#num_outlier_files=0
for i in $(seq 1 $2)
do
	#Use the parentheses to make this it's own subshell
	#Without these, the i variable becomes a string
	(source 2a_Find_Outliers.sh $1)

	let index=$i-1

	cur_len=`wc -l $APP_OUT_DIR/outliers.txt | awk '{ print $1 }'`
	prev_len=`wc -l $APP_OUT_DIR/outliers$index.txt | awk '{ print $1 }'`

	if [[ "$cur_len" == "0" ]]
	then
		break
	fi

	if [[ "$i" -gt 1 ]] && [[ $cur_len == $prev_len ]]
	then

		source 2c_Recollect_All_PMCs.sh $1

	else

		source 2b_Recollect_Specific_PMCs.sh $1
		
	fi

	cd $APP_OUT_DIR

	mv outliers.txt outliers$i.txt

	cd $COLLECTION_SCRIPTS_PATH

done
