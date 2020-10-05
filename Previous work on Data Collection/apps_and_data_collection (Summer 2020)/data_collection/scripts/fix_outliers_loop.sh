#! /bin/bash

# $1 is the application
# $2 is the number of iterations

#num_outlier_files=0
for i in $(seq 1 $2)
do
	echo "Before find_outliers"
	sudo ./find_outliers.sh $1
	echo "After find_outliers"
	let index=$i-1

	cur_len=`wc -l ../../apps/$1/outlier_dir/outliers.txt | awk '{ print $1 }'`
	prev_len=`wc -l ../../apps/$1/outlier_dir/outliers$index.txt | awk '{ print $1 }'`

	if [[ "$cur_len" == "0" ]]
	then
  		#num_outlier_files=$i
		break
	fi

	if [[ "$i" -gt 1 ]] && [[ $cur_len == $prev_len ]]
	then
		echo "Before full_outlier_run"
		sudo ./full_outlier_run.sh $1
		echo "After full_outlier_run"
	else
		echo "Before recollect"
		sudo ./recollect.sh $1
		echo "After recollect"
	fi

	cd ../../apps/$1/outlier_dir

	mv outliers.txt outliers$i.txt

	cd ../../../data_collection/scripts

done

#cd /home/rock/rockpi4/benchmarks/eigenbench/outlier_dir
#sudo ./analyze_outliers.py $num_outlier_files > summary.txt
