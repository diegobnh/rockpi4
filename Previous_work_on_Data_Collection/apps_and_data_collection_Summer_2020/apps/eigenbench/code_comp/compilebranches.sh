# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
#
# The above notice shall be included in all copies or substantial
# portions of this file.
rm -r binbranches
mkdir binbranches
for file in ../code_gen/srcbranches/*
do
 filename="${file##*/}"
 filename="${filename%.*}"
 gcc  -I../Energymonitorlibrary/include/ -fopenmp $file -o ./binbranches/$filename -lm
 value=$?
 echo $value
 if [[ $value -ne 0 ]]; then
     break
 fi
done
