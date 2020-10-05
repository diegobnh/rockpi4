#! /bin/bash

dirs=()

./id_bad_binaries.sh $1 > problems.txt

while read line; do
	arr=(${line//:/ })
	flag="0"
	for i in  "${dirs[@]}"
	do
		if [[ "$i" = "${arr[0]}"  ]]; then
			flag="1"
		fi
	done

	if [[ "$flag" = "0"  ]]; then
		dirs+=( ${arr[0]} )
	fi

done < problems.txt

rm problems.txt

cd ../../apps/$1/pmcs

rm */pmcs_schedule.txt

for i in "${dirs[@]}"; do
	cd $i
	echo "temp" > pmcs_schedule.txt
	cd ..
done


cd ../../../data_collection/scripts
sudo ./full_outlier_run.sh $1

mv ../../apps/$1/outlier_dir ../../apps/$1/good_outlier_dir
mkdir ../../apps/$1/outlier_dir

sudo ./fix_outliers_loop.sh $1 100
