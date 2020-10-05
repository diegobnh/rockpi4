# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
#!/bin/bash
r=readings
turns=2
readfreq=1
mkdir $r
for file in binreductions/*
do
    benchmark="${file##*/}"
    echo "Benchmark name " $benchmark
    echo "Benchmark file " $file
    if [[ $benchmark  == *"n4b0"* ]]
	then
	echo "Skip" $benchmark
    else
	for (( i=1; i <= $turns; i++ ))
	do
    	    sudo ./$file > $r/$benchmark.$i.txt
    	    mv prof.txt $r/$benchmark.prof.$i.txt
	done
	sleep 1m
    fi
done
mv $r readingsreductions
 
