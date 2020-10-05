#! /bin/bash


FOLDERS=`ls -d */`

for i in $FOLDERS
do
	cd $i

	dir="${i#"bin"}"
	dir="${dir%"/"}"

	FILES=`ls`
	for j in $FILES
	do
		mv $j $dir"_"$j
	done
	cd ..
done
