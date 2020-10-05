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
add=1
mkdir $r
for file in binfor/*
do
    benchmark="${file##*/}"
    echo "Benchmark file " $file
    echo "Benchmark name " $benchmark
    for (( i=1; i <= $turns; i++ ))
    do
    	sudo ./$file > $r/$benchmark.$((i+add)).txt
    	mv prof.txt $r/$benchmark.prof.$((i+add)).txt
    done
    sleep 2m
done
mv $r readingsfor
 
