#! /bin/bash

dirs=()

(source id_bad_binaries.sh $1 > problems.txt)

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

cd $APP_PMC_DIR"/"

rm */pmcs_schedule.txt

for i in "${dirs[@]}"; do
	cd $i
	echo "temp" > pmcs_schedule.txt
	cd ..
done


cd $COLLECTION_SCRIPTS_PATH

(source full_outlier_run.sh $1)
echo "Here"

rm -r $APP_GOUT_DIR
mv $APP_OUT_DIR $APP_GOUT_DIR
mkdir $APP_OUT_DIR

(source fix_outliers_loop.sh $1 100)
