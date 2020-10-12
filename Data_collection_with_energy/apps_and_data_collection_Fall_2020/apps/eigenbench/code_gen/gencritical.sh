# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
#
# The above notice shall be included in all copies or substantial
# portions of this file.
SRC=srccritical
rm -r $SRC
mkdir $SRC

#Cluster Configuration: 4 little
#python2 ../python/openmpeigenbench_critical.py -c 1  -n 4 -b 0  > ./$SRC/tcr1n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 2  -n 4 -b 0  > ./$SRC/tcr2n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 3  -n 4 -b 0  > ./$SRC/tcr3n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 5  -n 4 -b 0  > ./$SRC/tcr5n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 10  -n 4 -b 0  > ./$SRC/tcr10n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 20  -n 4 -b 0  > ./$SRC/tcr20n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 25  -n 4 -b 0  > ./$SRC/tcr25n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 50  -n 4 -b 0  > ./$SRC/tcr50n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 75  -n 4 -b 0  > ./$SRC/tcr75n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 100  -n 4 -b 0  > ./$SRC/tcr100n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 200  -n 4 -b 0  > ./$SRC/tcr200n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 250  -n 4 -b 0  > ./$SRC/tcr250n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 500  -n 4 -b 0  > ./$SRC/tcr500n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 600  -n 4 -b 0  > ./$SRC/tcr600n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 750  -n 4 -b 0  > ./$SRC/tcr750n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 1000  -n 4 -b 0  > ./$SRC/tcr1000n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 2000  -n 4 -b 0  > ./$SRC/tcr2000n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 4000  -n 4 -b 0  > ./$SRC/tcr4000n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 8000  -n 4 -b 0  > ./$SRC/tcr8000n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 16000  -n 4 -b 0  > ./$SRC/tcr16000n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 32000  -n 4 -b 0  > ./$SRC/tcr32000n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 64000  -n 4 -b 0  > ./$SRC/tcr64000n4b0.c
#python2 ../python/openmpeigenbench_critical.py -c 128000  -n 4 -b 0  > ./$SRC/tcr128000n4b0.c

#Cluster Configuration: 2 Big
#python2 ../python/openmpeigenbench_critical.py -c 1  -n 2 -b 2  > ./$SRC/1tcr1n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 2  -n 2 -b 2  > ./$SRC/1tcr2n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 3  -n 2 -b 2  > ./$SRC/1tcr3n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 5  -n 2 -b 2  > ./$SRC/1tcr5n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 10  -n 2 -b 2  > ./$SRC/1tcr10n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 20  -n 2 -b 2  > ./$SRC/1tcr20n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 25  -n 2 -b 2  > ./$SRC/1tcr25n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 50  -n 2 -b 2  > ./$SRC/1tcr50n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 75  -n 2 -b 2  > ./$SRC/1tcr75n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 100  -n 2 -b 2  > ./$SRC/1tcr100n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 200  -n 2 -b 2  > ./$SRC/1tcr200n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 250  -n 2 -b 2  > ./$SRC/1tcr250n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 500  -n 2 -b 2  > ./$SRC/1tcr500n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 600  -n 2 -b 2  > ./$SRC/1tcr600n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 750  -n 2 -b 2  > ./$SRC/1tcr750n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 1000  -n 2 -b 2  > ./$SRC/1tcr1000n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 2000  -n 2 -b 2  > ./$SRC/1tcr2000n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 4000  -n 2 -b 2  > ./$SRC/1tcr4000n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 8000  -n 2 -b 2  > ./$SRC/1tcr8000n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 16000  -n 2 -b 2  > ./$SRC/1tcr16000n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 32000  -n 2 -b 2  > ./$SRC/1tcr32000n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 64000  -n 2 -b 2  > ./$SRC/1tcr64000n2b2.c
#python2 ../python/openmpeigenbench_critical.py -c 128000  -n 2 -b 2  > ./$SRC/1tcr128000n2b2.c


#Cluster Configuration: 4 Little and 2 Big
#python2 ../python/openmpeigenbench_critical.py -c 1  -n 6 -b 2  > ./$SRC/2tcr1n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 2  -n 6 -b 2  > ./$SRC/2tcr2n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 3  -n 6 -b 2  > ./$SRC/2tcr3n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 5  -n 6 -b 2  > ./$SRC/2tcr5n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 10  -n 6 -b 2  > ./$SRC/2tcr10n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 20  -n 6 -b 2  > ./$SRC/2tcr20n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 25  -n 6 -b 2  > ./$SRC/2tcr25n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 50  -n 6 -b 2  > ./$SRC/2tcr50n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 75  -n 6 -b 2  > ./$SRC/2tcr75n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 100  -n 6 -b 2  > ./$SRC/2tcr100n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 200  -n 6 -b 2  > ./$SRC/2tcr200n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 250  -n 6 -b 2  > ./$SRC/2tcr250n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 500  -n 6 -b 2  > ./$SRC/2tcr500n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 600  -n 6 -b 2  > ./$SRC/2tcr600n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 750  -n 6 -b 2  > ./$SRC/2tcr750n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 1000  -n 6 -b 2  > ./$SRC/2tcr1000n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 2000  -n 6 -b 2  > ./$SRC/2tcr2000n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 4000  -n 6 -b 2  > ./$SRC/2tcr4000n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 8000  -n 6 -b 2  > ./$SRC/2tcr8000n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 16000  -n 6 -b 2  > ./$SRC/2tcr16000n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 32000  -n 6 -b 2  > ./$SRC/2tcr32000n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 64000  -n 6 -b 2  > ./$SRC/2tcr64000n6b2.c
#python2 ../python/openmpeigenbench_critical.py -c 128000  -n 6 -b 2 > ./$SRC/2tcr128000n6b2.c








#Cluster Configuration: 4 little
python2 ../python/openmpeigenbench_critical.py -c 256000  -n 4 -b 0  > ./$SRC/tcr1n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 512000  -n 4 -b 0  > ./$SRC/tcr2n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 1024000  -n 4 -b 0  > ./$SRC/tcr3n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 2048000  -n 4 -b 0  > ./$SRC/tcr5n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 4096000  -n 4 -b 0  > ./$SRC/tcr10n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 8192000  -n 4 -b 0  > ./$SRC/tcr20n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 16384000  -n 4 -b 0  > ./$SRC/tcr25n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 32768000  -n 4 -b 0  > ./$SRC/tcr50n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 65536000  -n 4 -b 0  > ./$SRC/tcr75n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 70000000  -n 4 -b 0  > ./$SRC/tcr100n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 80000000  -n 4 -b 0  > ./$SRC/tcr200n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 90000000  -n 4 -b 0  > ./$SRC/tcr250n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 100000000  -n 4 -b 0  > ./$SRC/tcr500n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 110000000  -n 4 -b 0  > ./$SRC/tcr600n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 120000000  -n 4 -b 0  > ./$SRC/tcr750n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 130000000  -n 4 -b 0  > ./$SRC/tcr1000n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 140000000  -n 4 -b 0  > ./$SRC/tcr2000n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 150000000  -n 4 -b 0  > ./$SRC/tcr4000n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 160000000  -n 4 -b 0  > ./$SRC/tcr8000n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 170000000  -n 4 -b 0  > ./$SRC/tcr16000n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 180000000  -n 4 -b 0  > ./$SRC/tcr32000n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 190000000  -n 4 -b 0  > ./$SRC/tcr64000n4b0.c
python2 ../python/openmpeigenbench_critical.py -c 200000000  -n 4 -b 0  > ./$SRC/tcr128000n4b0.c

#Cluster Configuration: 2 Big
python2 ../python/openmpeigenbench_critical.py -c 256000  -n 2 -b 2  > ./$SRC/1tcr1n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 512000  -n 2 -b 2  > ./$SRC/1tcr2n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 1024000  -n 2 -b 2  > ./$SRC/1tcr3n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 2048000  -n 2 -b 2  > ./$SRC/1tcr5n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 4096000  -n 2 -b 2  > ./$SRC/1tcr10n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 8192000  -n 2 -b 2  > ./$SRC/1tcr20n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 16384000  -n 2 -b 2  > ./$SRC/1tcr25n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 32768000  -n 2 -b 2  > ./$SRC/1tcr50n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 65536000  -n 2 -b 2  > ./$SRC/1tcr75n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 70000000  -n 2 -b 2  > ./$SRC/1tcr100n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 80000000  -n 2 -b 2  > ./$SRC/1tcr200n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 90000000  -n 2 -b 2  > ./$SRC/1tcr250n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 100000000  -n 2 -b 2  > ./$SRC/1tcr500n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 110000000  -n 2 -b 2  > ./$SRC/1tcr600n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 120000000  -n 2 -b 2  > ./$SRC/1tcr750n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 130000000  -n 2 -b 2  > ./$SRC/1tcr1000n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 140000000  -n 2 -b 2  > ./$SRC/1tcr2000n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 150000000  -n 2 -b 2  > ./$SRC/1tcr4000n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 160000000  -n 2 -b 2  > ./$SRC/1tcr8000n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 170000000  -n 2 -b 2  > ./$SRC/1tcr16000n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 180000000  -n 2 -b 2  > ./$SRC/1tcr32000n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 190000000  -n 2 -b 2  > ./$SRC/1tcr64000n2b2.c
python2 ../python/openmpeigenbench_critical.py -c 200000000  -n 2 -b 2  > ./$SRC/1tcr128000n2b2.c


#Cluster Configuration: 4 Little and 2 Big
python2 ../python/openmpeigenbench_critical.py -c 256000  -n 6 -b 2  > ./$SRC/2tcr1n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 512000  -n 6 -b 2  > ./$SRC/2tcr2n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 1024000  -n 6 -b 2  > ./$SRC/2tcr3n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 2048000  -n 6 -b 2  > ./$SRC/2tcr5n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 4096000  -n 6 -b 2  > ./$SRC/2tcr10n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 8192000  -n 6 -b 2  > ./$SRC/2tcr20n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 16384000  -n 6 -b 2  > ./$SRC/2tcr25n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 32768000  -n 6 -b 2  > ./$SRC/2tcr50n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 65536000  -n 6 -b 2  > ./$SRC/2tcr75n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 70000000  -n 6 -b 2  > ./$SRC/2tcr100n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 80000000  -n 6 -b 2  > ./$SRC/2tcr200n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 90000000  -n 6 -b 2  > ./$SRC/2tcr250n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 100000000  -n 6 -b 2  > ./$SRC/2tcr500n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 110000000  -n 6 -b 2  > ./$SRC/2tcr600n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 120000000  -n 6 -b 2  > ./$SRC/2tcr750n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 130000000  -n 6 -b 2  > ./$SRC/2tcr1000n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 140000000  -n 6 -b 2  > ./$SRC/2tcr2000n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 150000000  -n 6 -b 2  > ./$SRC/2tcr4000n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 160000000  -n 6 -b 2  > ./$SRC/2tcr8000n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 170000000  -n 6 -b 2  > ./$SRC/2tcr16000n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 180000000  -n 6 -b 2  > ./$SRC/2tcr32000n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 190000000  -n 6 -b 2  > ./$SRC/2tcr64000n6b2.c
python2 ../python/openmpeigenbench_critical.py -c 200000000  -n 6 -b 2 > ./$SRC/2tcr128000n6b2.c
