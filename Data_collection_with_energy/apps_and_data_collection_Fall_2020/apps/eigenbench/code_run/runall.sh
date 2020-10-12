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
bigfreq=(1800000 1600000 1400000 1200000)
eigenbench=(rundependence.sh runfalsestride.py runfor.sh runnofalse.sh runcritcal.sh runfalse.sh runflush.sh runmemory.sh runreductions.sh runvaryfalse.sh)


for freq in "${bigfreq[@]}"
do
    mkdir b$freq
    echo $freq
    sudo ./changefreq.sh $freq
    for eigen in "${eigenbench[@]}"
    do
	./$eigen
    done
    mv readings* b$freq 
    sleep 10m
done
