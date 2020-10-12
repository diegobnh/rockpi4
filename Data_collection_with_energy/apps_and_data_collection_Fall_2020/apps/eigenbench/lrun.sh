# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
#!/bin/bash
r=readings
cs=readings/consolidated.txt
turns=5
readfreq=1
bigfreq=(1400000 1300000 1200000 1100000 1000000 900000 800000 700000  600000 500000 400000)
ov=overall.txt
declare -a benchmarks=(tc1m1  tc1m5  tc1m75  tc5m1  tc5m5  tc5m75  tc75m1  tc75m5  tc75m75)

for freq in "${bigfreq[@]}"
do
    echo $freq
    sudo ./changelfreq.sh $freq
    mkdir $r
    for benchmark in "${benchmarks[@]}"
    do
	echo "Benchmark Name " $benchmark >>$cs	
	for (( i=1; i <= $turns; i++ ))
	do
	    sudo ./bin/$benchmark > $r/$benchmark.$i.txt
	    mv prof.txt $r/$benchmark.prof.$i.txt
	    python consolidatepower.py -i ./$r/$benchmark.prof.$i.txt -s $readfreq >>$cs
	    grep "Elapsed "  $r/$benchmark.$i.txt >> $cs
	done
    done
    
    python ~/Desktop/avg.py -i readings/consolidated.txt -s $turns >>$ov
    mv $r readings_l$freq
    sleep 5m
done

sudo ./changelfreq.sh 1400000
