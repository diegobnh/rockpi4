# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
#!/bin/bash
r=readings_v2
cs=readings_v2/consolidated.txt
turns=5
readfreq=1
littlefreq=(1400000 1000000 600000)
#littlefreq=(1400000)
ov=overall.txt
shopt -s nullglob
benchmarks=(bin2/*)

for freq in "${littlefreq[@]}"
do
    echo $freq
    sudo ./changelfreq.sh $freq
    mkdir $r
    for benchmark in "${benchmarks[@]}"
    do
	bname=$(basename $benchmark)
	echo "Benchmark Name " $bname	
	for (( i=1; i <= $turns; i++ ))
	do
	    sudo $benchmark > $r/$bname.$i.txt
	    mv prof.txt $r/$bname.prof.$i.txt
	    python consolidatepower.py -i ./$r/$bname.prof.$i.txt -s $readfreq >>$cs
	    grep "Elapsed "  $r/$bname.$i.txt >> $cs
	done
    done
    
    python ~/Desktop/avg.py -i $cs -s $turns >>$ov
    mv $r readings_v2_little$freq
    sleep 5m
done
sudo ./changelfreq.sh 1400000
