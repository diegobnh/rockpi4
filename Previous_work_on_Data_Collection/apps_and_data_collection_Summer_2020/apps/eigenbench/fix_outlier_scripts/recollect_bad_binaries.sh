#! /bin/bash

cd /home/rock/rockpi4/benchmarks/eigenbench/fix_outlier_scripts

dirs=()

./id_bad_binaries.sh > problems.txt

while read line; do
	arr=(${line//:/ })
	flag="0"
	for i in  "${dirs[@]}"
	do
		#WRONG!!!
		if [[ "$i" = "${arr[0]}"  ]]; then
			flag="1"
		fi
	done

	if [[ "$flag" = "0"  ]]; then
		dirs+=( ${arr[0]} )
	fi

done < problems.txt

rm problems.txt

cd /home/rock/rockpi4/benchmarks/eigenbench/pmcs

rm */pmcs_schedule.txt

for i in "${dirs[@]}"; do
	cd $i
	echo "temp" > pmcs_schedule.txt
	cd ..
done

sudo ./../fix_outlier_scripts/full_outlier_run.sh

mv ../outlier_dir ../good_outlier_dir
mkdir ../outlier_dir

sudo ./../fix_outlier_scripts/fix_outlier_loop.sh 30
