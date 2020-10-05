# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
#
# The above notice shall be included in all copies or substantial
# portions of this file.
SRC=srcflush
rm -r $SRC
mkdir $SRC

#Cluster Configuration: 2 big
#python2 ../python/openmpeigenbench_flush.py -f 0.10  -n 2 -b 2  > ./$SRC/tflus10n2b2.c
#python2 ../python/openmpeigenbench_flush.py -f 0.20  -n 2 -b 2  > ./$SRC/tflus20n2b2.c
#python2 ../python/openmpeigenbench_flush.py -f 0.30  -n 2 -b 2  > ./$SRC/tflus30n2b2.c
#python2 ../python/openmpeigenbench_flush.py -f 0.40  -n 2 -b 2  > ./$SRC/tflus40n2b2.c
#python2 ../python/openmpeigenbench_flush.py -f 0.50  -n 2 -b 2  > ./$SRC/tflus50n2b2.c
#python2 ../python/openmpeigenbench_flush.py -f 0.60  -n 2 -b 2  > ./$SRC/tflus60n2b2.c
#python2 ../python/openmpeigenbench_flush.py -f 0.70  -n 2 -b 2  > ./$SRC/tflus70n2b2.c
#python2 ../python/openmpeigenbench_flush.py -f 0.80  -n 2 -b 2  > ./$SRC/tflus80n2b2.c
#python2 ../python/openmpeigenbench_flush.py -f 0.90  -n 2 -b 2  > ./$SRC/tflus90n2b2.c
#python2 ../python/openmpeigenbench_flush.py -f 1.00  -n 2 -b 2  > ./$SRC/tflus100n2b2.c
#python2 ../python/openmpeigenbench_flush.py -f 2.00  -n 2 -b 2  > ./$SRC/tflus200n2b2.c
#python2 ../python/openmpeigenbench_flush.py -f 3.00  -n 2 -b 2  > ./$SRC/tflus300n2b2.c
#python2 ../python/openmpeigenbench_flush.py -f 4.00  -n 2 -b 2  > ./$SRC/tflus400n2b2.c
#python2 ../python/openmpeigenbench_flush.py -f 5.00  -n 2 -b 2  > ./$SRC/tflus500n2b2.c
#python2 ../python/openmpeigenbench_flush.py -f 7.00  -n 2 -b 2  > ./$SRC/tflus700n2b2.c
#python2 ../python/openmpeigenbench_flush.py -f 9.00  -n 2 -b 2  > ./$SRC/tflus900n2b2.c

#Cluster Configuration: 4 little
#python2 ../python/openmpeigenbench_flush.py -f 0.10  -n 4 -b 0  > ./$SRC/tflus10n4b0.c
#python2 ../python/openmpeigenbench_flush.py -f 0.20  -n 4 -b 0  > ./$SRC/tflus20n4b0.c
#python2 ../python/openmpeigenbench_flush.py -f 0.30  -n 4 -b 0  > ./$SRC/tflus30n4b0.c
#python2 ../python/openmpeigenbench_flush.py -f 0.40  -n 4 -b 0  > ./$SRC/tflus40n4b0.c
#python2 ../python/openmpeigenbench_flush.py -f 0.50  -n 4 -b 0  > ./$SRC/tflus50n4b0.c
#python2 ../python/openmpeigenbench_flush.py -f 0.60  -n 4 -b 0  > ./$SRC/tflus60n4b0.c
#python2 ../python/openmpeigenbench_flush.py -f 0.70  -n 4 -b 0  > ./$SRC/tflus70n4b0.c
#python2 ../python/openmpeigenbench_flush.py -f 0.80  -n 4 -b 0  > ./$SRC/tflus80n4b0.c
#python2 ../python/openmpeigenbench_flush.py -f 0.90  -n 4 -b 0  > ./$SRC/tflus90n4b0.c
#python2 ../python/openmpeigenbench_flush.py -f 1.00  -n 4 -b 0  > ./$SRC/tflus100n4b0.c
#python2 ../python/openmpeigenbench_flush.py -f 2.00  -n 4 -b 0  > ./$SRC/tflus200n4b0.c
#python2 ../python/openmpeigenbench_flush.py -f 3.00  -n 4 -b 0  > ./$SRC/tflus300n4b0.c
#python2 ../python/openmpeigenbench_flush.py -f 4.00  -n 4 -b 0  > ./$SRC/tflus400n4b0.c
#python2 ../python/openmpeigenbench_flush.py -f 5.00  -n 4 -b 0  > ./$SRC/tflus500n4b0.c
#python2 ../python/openmpeigenbench_flush.py -f 7.00  -n 4 -b 0  > ./$SRC/tflus700n4b0.c
#python2 ../python/openmpeigenbench_flush.py -f 9.00  -n 4 -b 0  > ./$SRC/tflus900n4b0.c

#Cluster Configuration: 4 little and 2 big
#python2 ../python/openmpeigenbench_flush.py -f 0.10  -n 6 -b 2  > ./$SRC/tflus10n6b2.c
#python2 ../python/openmpeigenbench_flush.py -f 0.20  -n 6 -b 2  > ./$SRC/tflus20n6b2.c
#python2 ../python/openmpeigenbench_flush.py -f 0.30  -n 6 -b 2  > ./$SRC/tflus30n6b2.c
#python2 ../python/openmpeigenbench_flush.py -f 0.40  -n 6 -b 2  > ./$SRC/tflus40n6b2.c
#python2 ../python/openmpeigenbench_flush.py -f 0.50  -n 6 -b 2  > ./$SRC/tflus50n6b2.c
#python2 ../python/openmpeigenbench_flush.py -f 0.60  -n 6 -b 2  > ./$SRC/tflus60n6b2.c
#python2 ../python/openmpeigenbench_flush.py -f 0.70  -n 6 -b 2  > ./$SRC/tflus70n6b2.c
#python2 ../python/openmpeigenbench_flush.py -f 0.80  -n 6 -b 2  > ./$SRC/tflus80n6b2.c
#python2 ../python/openmpeigenbench_flush.py -f 0.90  -n 6 -b 2  > ./$SRC/tflus90n6b2.c
#python2 ../python/openmpeigenbench_flush.py -f 1.00  -n 6 -b 2  > ./$SRC/tflus100n6b2.c
#python2 ../python/openmpeigenbench_flush.py -f 2.00  -n 6 -b 2  > ./$SRC/tflus200n6b2.c
#python2 ../python/openmpeigenbench_flush.py -f 3.00  -n 6 -b 2  > ./$SRC/tflus300n6b2.c
#python2 ../python/openmpeigenbench_flush.py -f 4.00  -n 6 -b 2  > ./$SRC/tflus400n6b2.c
#python2 ../python/openmpeigenbench_flush.py -f 5.00  -n 6 -b 2  > ./$SRC/tflus500n6b2.c
#python2 ../python/openmpeigenbench_flush.py -f 7.00  -n 6 -b 2  > ./$SRC/tflus700n6b2.c
#python2 ../python/openmpeigenbench_flush.py -f 9.00  -n 6 -b 2  > ./$SRC/tflus900n6b2.c








#Cluster Configuration: 2 big
python2 ../python/openmpeigenbench_flush.py -f 10.10  -n 2 -b 2  > ./$SRC/tflus10n2b2.c
python2 ../python/openmpeigenbench_flush.py -f 20.20  -n 2 -b 2  > ./$SRC/tflus20n2b2.c
python2 ../python/openmpeigenbench_flush.py -f 30.30  -n 2 -b 2  > ./$SRC/tflus30n2b2.c
python2 ../python/openmpeigenbench_flush.py -f 40.40  -n 2 -b 2  > ./$SRC/tflus40n2b2.c
python2 ../python/openmpeigenbench_flush.py -f 50.50  -n 2 -b 2  > ./$SRC/tflus50n2b2.c
python2 ../python/openmpeigenbench_flush.py -f 60.60  -n 2 -b 2  > ./$SRC/tflus60n2b2.c
python2 ../python/openmpeigenbench_flush.py -f 70.70  -n 2 -b 2  > ./$SRC/tflus70n2b2.c
python2 ../python/openmpeigenbench_flush.py -f 80.80  -n 2 -b 2  > ./$SRC/tflus80n2b2.c
python2 ../python/openmpeigenbench_flush.py -f 90.90  -n 2 -b 2  > ./$SRC/tflus90n2b2.c
python2 ../python/openmpeigenbench_flush.py -f 100.00  -n 2 -b 2  > ./$SRC/tflus100n2b2.c
python2 ../python/openmpeigenbench_flush.py -f 110.00  -n 2 -b 2  > ./$SRC/tflus200n2b2.c
python2 ../python/openmpeigenbench_flush.py -f 120.00  -n 2 -b 2  > ./$SRC/tflus300n2b2.c
python2 ../python/openmpeigenbench_flush.py -f 130.00  -n 2 -b 2  > ./$SRC/tflus400n2b2.c
python2 ../python/openmpeigenbench_flush.py -f 140.00  -n 2 -b 2  > ./$SRC/tflus500n2b2.c
python2 ../python/openmpeigenbench_flush.py -f 150.00  -n 2 -b 2  > ./$SRC/tflus700n2b2.c
python2 ../python/openmpeigenbench_flush.py -f 160.00  -n 2 -b 2  > ./$SRC/tflus900n2b2.c

#Cluster Configuration: 4 little
python2 ../python/openmpeigenbench_flush.py -f 10.10  -n 4 -b 0  > ./$SRC/tflus10n4b0.c
python2 ../python/openmpeigenbench_flush.py -f 20.20  -n 4 -b 0  > ./$SRC/tflus20n4b0.c
python2 ../python/openmpeigenbench_flush.py -f 30.30  -n 4 -b 0  > ./$SRC/tflus30n4b0.c
python2 ../python/openmpeigenbench_flush.py -f 40.40  -n 4 -b 0  > ./$SRC/tflus40n4b0.c
python2 ../python/openmpeigenbench_flush.py -f 50.50  -n 4 -b 0  > ./$SRC/tflus50n4b0.c
python2 ../python/openmpeigenbench_flush.py -f 60.60  -n 4 -b 0  > ./$SRC/tflus60n4b0.c
python2 ../python/openmpeigenbench_flush.py -f 70.70  -n 4 -b 0  > ./$SRC/tflus70n4b0.c
python2 ../python/openmpeigenbench_flush.py -f 80.80  -n 4 -b 0  > ./$SRC/tflus80n4b0.c
python2 ../python/openmpeigenbench_flush.py -f 90.90  -n 4 -b 0  > ./$SRC/tflus90n4b0.c
python2 ../python/openmpeigenbench_flush.py -f 100.00  -n 4 -b 0  > ./$SRC/tflus100n4b0.c
python2 ../python/openmpeigenbench_flush.py -f 110.00  -n 4 -b 0  > ./$SRC/tflus200n4b0.c
python2 ../python/openmpeigenbench_flush.py -f 120.00  -n 4 -b 0  > ./$SRC/tflus300n4b0.c
python2 ../python/openmpeigenbench_flush.py -f 130.00  -n 4 -b 0  > ./$SRC/tflus400n4b0.c
python2 ../python/openmpeigenbench_flush.py -f 140.00  -n 4 -b 0  > ./$SRC/tflus500n4b0.c
python2 ../python/openmpeigenbench_flush.py -f 150.00  -n 4 -b 0  > ./$SRC/tflus700n4b0.c
python2 ../python/openmpeigenbench_flush.py -f 160.00  -n 4 -b 0  > ./$SRC/tflus900n4b0.c

#Cluster Configuration: 4 little and 2 big
python2 ../python/openmpeigenbench_flush.py -f 10.10  -n 6 -b 2  > ./$SRC/tflus10n6b2.c
python2 ../python/openmpeigenbench_flush.py -f 20.20  -n 6 -b 2  > ./$SRC/tflus20n6b2.c
python2 ../python/openmpeigenbench_flush.py -f 30.30  -n 6 -b 2  > ./$SRC/tflus30n6b2.c
python2 ../python/openmpeigenbench_flush.py -f 40.40  -n 6 -b 2  > ./$SRC/tflus40n6b2.c
python2 ../python/openmpeigenbench_flush.py -f 50.50  -n 6 -b 2  > ./$SRC/tflus50n6b2.c
python2 ../python/openmpeigenbench_flush.py -f 60.60  -n 6 -b 2  > ./$SRC/tflus60n6b2.c
python2 ../python/openmpeigenbench_flush.py -f 70.70  -n 6 -b 2  > ./$SRC/tflus70n6b2.c
python2 ../python/openmpeigenbench_flush.py -f 80.80  -n 6 -b 2  > ./$SRC/tflus80n6b2.c
python2 ../python/openmpeigenbench_flush.py -f 90.90  -n 6 -b 2  > ./$SRC/tflus90n6b2.c
python2 ../python/openmpeigenbench_flush.py -f 100.00  -n 6 -b 2  > ./$SRC/tflus100n6b2.c
python2 ../python/openmpeigenbench_flush.py -f 110.00  -n 6 -b 2  > ./$SRC/tflus200n6b2.c
python2 ../python/openmpeigenbench_flush.py -f 120.00  -n 6 -b 2  > ./$SRC/tflus300n6b2.c
python2 ../python/openmpeigenbench_flush.py -f 130.00  -n 6 -b 2  > ./$SRC/tflus400n6b2.c
python2 ../python/openmpeigenbench_flush.py -f 140.00  -n 6 -b 2  > ./$SRC/tflus500n6b2.c
python2 ../python/openmpeigenbench_flush.py -f 150.00  -n 6 -b 2  > ./$SRC/tflus700n6b2.c
python2 ../python/openmpeigenbench_flush.py -f 160.00  -n 6 -b 2  > ./$SRC/tflus900n6b2.c
