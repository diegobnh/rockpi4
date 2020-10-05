#! /bin/bash
alert=10

for k in $(seq 1 $NUM_ITERATIONS_FOR_OUTLIER)
do
	source ./3.1_Check_if_exist_outliers.sh 

	current_number_of_outliers=`wc -l $BENCHMARK_PATH/outlier/outliers.txt | awk '{ print $1 }'`
        current_hash=$(md5sum $BENCHMARK_PATH/outlier/outliers.txt | awk '{print $1}')

        if [[ "$k" -gt 1 ]]
        then
                let prev_k=$k-1
	        prev_hash=$(md5sum $BENCHMARK_PATH/outlier/outliers$prev_k.txt | awk '{print $1}') 
        fi

	if [[ "$current_number_of_outliers" == "0" ]]
	then
                echo "No exist outlier!"
		break
        elif [[ $current_hash != $prev_hash ]] #means it reduced the number of outliers
        then
                echo "Exist outlier! Recollect specific pmcs."  
                source ./3.2_Recollect_specific_pmcs.sh 
                number_of_attempts=0
        elif [[ $current_hash == $prev_hash ]] && [[ "$number_of_attempts" -lt 10 ]] #not reduced
        then
                source ./3.2_Recollect_specific_pmcs.sh 
                let number_of_attempts=$number_of_attempts+1
        else #not reduced the ouliers for 10 times 
                echo "Exist outlier! Recollect all pmcs."  
                source ./3.3_Recollect_all_pmcs.sh
	fi


	cd $BENCHMARK_PATH/outlier
	mv outliers.txt outliers$k.txt
	cd $DATA_COLLECTION_PATH/scripts
        if [[ "$k" -gt "$alert" ]]
        then
             echo "Iteration "$k" (Management Outlier)" 
             let alert=$alert+10
        fi
done

