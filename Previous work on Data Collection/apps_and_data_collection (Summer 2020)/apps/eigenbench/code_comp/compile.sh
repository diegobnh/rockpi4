# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
for file in src/*
do
 # do something on $file
# echo "$file"
 filename="${file##*/}"
 filename="${filename%.*}"
# echo $filename
 gcc  -I../Energymonitorlibrary/include/ -fopenmp $file -lenergymodule -o ./bin/$filename
done
