# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
#!/bin/bash
turns=5
readfreq=1
bigfreq=(2000000 1800000 1400000 1000000 600000)
#bigfreq=(2000000)
ov=overall.txt
shopt -s nullglob
benchmarks=(bin2/*)

for freq in "${bigfreq[@]}"
do
    echo $freq
    r="readings_v2"$freq
    echo $r
#    mkdir $r
    cs=$r"/consolidated.txt"
    echo $cs
    rm $cs
    for benchmark in "${benchmarks[@]}"
    do
	bname=$(basename $benchmark)
	echo "Benchmark Name " $bname	
	for (( i=1; i <= $turns; i++ ))
	do
	    python consolidatepower.py -i ./$r/$bname.prof.$i.txt -s $readfreq >>$cs
	    grep "Elapsed "  $r/$bname.$i.txt >> $cs
	    grep "The number of iterations" $r/$bname.$i.txt >> $cs
	    echo "*** End of benchmark" >> $cs
	done
    done
done
# lrun not done
