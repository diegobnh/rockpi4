#! /bin/bash

num_outlier_files=0
for i in $(seq 1 $1)
do

	cd /home/rock/rockpi4/benchmarks/eigenbench/fix_outlier_scripts
	sudo ./find_outliers.sh

	let index=$i-1

	cur_len=`wc -l ../outlier_dir/outliers.txt | awk '{ print $1 }'`
	prev_len=`wc -l ../outlier_dir/outliers$index.txt | awk '{ print $1 }'`

	if [[ "$cur_len" == "0" ]]
	then
		num_outlier_files=$i
		break
	fi

	if [[ "$i" -gt 1 ]] && [[ $cur_len == $prev_len ]]
	then
		sudo ./full_outlier_run.sh
	else
		sudo ./recollect.sh
	fi

	cd /home/rock/rockpi4/benchmarks/eigenbench/outlier_dir

	mv outliers.txt outliers$i.txt

done

cd /home/rock/rockpi4/benchmarks/eigenbench/outlier_dir
#sudo ./analyze_outliers.py $num_outlier_files > summary.txt
