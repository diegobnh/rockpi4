# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
#!/bin/bash
bigfreq=(1800000 1600000 1400000 1200000)

sudo ./changefreq.sh 2000000
$1
sudo rm -r b2000000/$2 || true
sudo mv ./$2 b2000000/
for freq in "${bigfreq[@]}"
do
    sudo ./changefreq.sh $freq
    $3
    sudo rm -r b$freq/$2 || true
    sudo mv ./$2 b$freq/
done
