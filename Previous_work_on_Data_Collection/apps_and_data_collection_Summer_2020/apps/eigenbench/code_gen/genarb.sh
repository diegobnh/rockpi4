# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
rm -r src2
mkdir src2
ompgen=openmpeigenbench_v2threadrestricted.py

python $ompgen -u 0    -i 1    -l NO > ./src2/tu0i1ln_v2.c
python $ompgen -u 0    -i 100  -l NO > ./src2/tu0i100ln_v2.c
python $ompgen -u 0    -i 1280 -l NO > ./src2/tu0i1280ln_v2.c
python $ompgen -u 0    -i 2560 -l NO > ./src2/tu0i2560ln_v2.c
python $ompgen -u 0    -i 5120 -l NO > ./src2/tu0i5120ln_v2.c
python $ompgen -u 0    -i 10240 -l NO > ./src2/tu0i10240ln_v2.c
python $ompgen -u 0    -i 100  -l YES > ./src2/tu0i100ly_v2.c
python $ompgen -u 0    -i 1280 -l YES > ./src2/tu0i1280ly_v2.c
python $ompgen -u 0    -i 2560 -l YES > ./src2/tu0i2560ly_v2.c
python $ompgen -u 0    -i 5120 -l YES > ./src2/tu0i5120ly_v2.c
python $ompgen -u 0    -i 10240 -l YES > ./src2/tu0i10240ly_v2.c


python $ompgen -u 0.1    -i 1  -l NO > ./src2/tu1i1ln_v2.c
python $ompgen -u 0.1    -i 100  -l NO > ./src2/tu1i100ln_v2.c
python $ompgen -u 0.1    -i 1280 -l NO > ./src2/tu1i1280ln_v2.c
python $ompgen -u 0.1    -i 2560 -l NO > ./src2/tu1i2560ln_v2.c
python $ompgen -u 0.1    -i 5120 -l NO > ./src2/tu1i5120ln_v2.c
python $ompgen -u 0.1   -i 10240 -l NO > ./src2/tu1i10240ln_v2.c
python $ompgen -u 0.1    -i 100  -l YES > ./src2/tu1i100ly_v2.c
python $ompgen -u 0.1    -i 1280 -l YES > ./src2/tu1i1280ly_v2.c
python $ompgen -u 0.1    -i 2560 -l YES > ./src2/tu1i2560ly_v2.c
python $ompgen -u 0.1    -i 5120 -l YES > ./src2/tu1i5120ly_v2.c
python $ompgen -u 0.1   -i 10240 -l YES > ./src2/tu1i10240ly_v2.c

python $ompgen -u 0.2    -i 1  -l NO > ./src2/tu2i1ln_v2.c
python $ompgen -u 0.2    -i 100  -l NO > ./src2/tu2i100ln_v2.c
python $ompgen -u 0.2    -i 1280 -l NO > ./src2/tu2i1280ln_v2.c
python $ompgen -u 0.2    -i 2560 -l NO > ./src2/tu2i2560ln_v2.c
python $ompgen -u 0.2    -i 5120 -l NO > ./src2/tu2i5120ln_v2.c
python $ompgen -u 0.2   -i 10240 -l NO > ./src2/tu2i10240ln_v2.c
python $ompgen -u 0.2    -i 100  -l YES > ./src2/tu2i100ly_v2.c
python $ompgen -u 0.2    -i 1280 -l YES > ./src2/tu2i1280ly_v2.c
python $ompgen -u 0.2    -i 2560 -l YES > ./src2/tu2i2560ly_v2.c
python $ompgen -u 0.2    -i 5120 -l YES > ./src2/tu2i5120ly_v2.c
python $ompgen -u 0.2   -i 10240 -l YES > ./src2/tu2i10240ly_v2.c

python $ompgen -u 0.25    -i 1  -l NO > ./src2/tu25i1ln_v2.c
python $ompgen -u 0.25    -i 100  -l NO > ./src2/tu25i100ln_v2.c
python $ompgen -u 0.25    -i 1280 -l NO > ./src2/tu25i1280ln_v2.c
python $ompgen -u 0.25    -i 2560 -l NO > ./src2/tu25i2560ln_v2.c
python $ompgen -u 0.25    -i 5120 -l NO > ./src2/tu25i5120ln_v2.c
python $ompgen -u 0.25   -i 10240 -l NO > ./src2/tu25i10240ln_v2.c
python $ompgen -u 0.25    -i 100  -l YES > ./src2/tu25i100ly_v2.c
python $ompgen -u 0.25    -i 1280 -l YES > ./src2/tu25i1280ly_v2.c
python $ompgen -u 0.25    -i 2560 -l YES > ./src2/tu25i2560ly_v2.c
python $ompgen -u 0.25    -i 5120 -l YES > ./src2/tu25i5120ly_v2.c
python $ompgen -u 0.25   -i 10240 -l YES > ./src2/tu25i10240ly_v2.c

python $ompgen -u 0.3    -i 1  -l NO > ./src2/tu3i1ln_v2.c
python $ompgen -u 0.3    -i 100  -l NO > ./src2/tu3i100ln_v2.c
python $ompgen -u 0.3    -i 1280 -l NO > ./src2/tu3i1280ln_v2.c
python $ompgen -u 0.3    -i 2560 -l NO > ./src2/tu3i2560ln_v2.c
python $ompgen -u 0.3    -i 5120 -l NO > ./src2/tu3i5120ln_v2.c
python $ompgen -u 0.3   -i 10240 -l NO > ./src2/tu3i10240ln_v2.c
python $ompgen -u 0.3    -i 100  -l YES > ./src2/tu3i100ly_v2.c
python $ompgen -u 0.3    -i 1280 -l YES > ./src2/tu3i1280ly_v2.c
python $ompgen -u 0.3    -i 2560 -l YES > ./src2/tu3i2560ly_v2.c
python $ompgen -u 0.3    -i 5120 -l YES > ./src2/tu3i5120ly_v2.c
python $ompgen -u 0.3   -i 10240 -l YES > ./src2/tu3i10240ly_v2.c

python $ompgen -u 0.4    -i 1  -l NO > ./src2/tu4i1ln_v2.c
python $ompgen -u 0.4    -i 100  -l NO > ./src2/tu4i100ln_v2.c
python $ompgen -u 0.4    -i 1280 -l NO > ./src2/tu4i1280ln_v2.c
python $ompgen -u 0.4    -i 2560 -l NO > ./src2/tu4i2560ln_v2.c
python $ompgen -u 0.4    -i 5120 -l NO > ./src2/tu4i5120ln_v2.c
python $ompgen -u 0.4   -i 10240 -l NO > ./src2/tu4i10240ln_v2.c
python $ompgen -u 0.4    -i 100  -l YES > ./src2/tu4i100ly_v2.c
python $ompgen -u 0.4    -i 1280 -l YES > ./src2/tu4i1280ly_v2.c
python $ompgen -u 0.4    -i 2560 -l YES > ./src2/tu4i2560ly_v2.c
python $ompgen -u 0.4    -i 5120 -l YES > ./src2/tu4i5120ly_v2.c
python $ompgen -u 0.4   -i 10240 -l YES > ./src2/tu4i10240ly_v2.c
