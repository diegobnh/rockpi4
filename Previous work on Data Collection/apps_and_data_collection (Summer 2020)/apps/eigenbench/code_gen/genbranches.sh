# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
#
# The above notice shall be included in all copies or substantial
# portions of this file.
SRC=srcbranches
rm -r $SRC
mkdir $SRC

#Cluster Configuration: 2 big
#python2 ../python/openmpeigenbench_branches.py -r 0.5  -n 2 -b 2  > ./$SRC/tbr05n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 0.7  -n 2 -b 2  > ./$SRC/tbr07n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 0.9  -n 2 -b 2  > ./$SRC/tbr09n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 1  -n 2 -b 2  > ./$SRC/tbr1n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 1.5  -n 2 -b 2  > ./$SRC/tbr1.5n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 2  -n 2 -b 2  > ./$SRC/tbr2n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 2.5  -n 2 -b 2  > ./$SRC/tbr25n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 5  -n 2 -b 2  > ./$SRC/tbr5n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 10  -n 2 -b 2  > ./$SRC/tbr10n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 15  -n 2 -b 2  > ./$SRC/tbr15n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 20  -n 2 -b 2  > ./$SRC/tbr20n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 25  -n 2 -b 2  > ./$SRC/tbr25n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 30  -n 2 -b 2  > ./$SRC/tbr30n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 35  -n 2 -b 2  > ./$SRC/tbr35n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 30  -n 2 -b 2  > ./$SRC/tbr30n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 40  -n 2 -b 2  > ./$SRC/tbr40n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 45  -n 2 -b 2  > ./$SRC/tbr45n2b2.c
#python2 ../python/openmpeigenbench_branches.py -r 50  -n 2 -b 2  > ./$SRC/tbr50n2b2.c


#Cluster Configuration: 4 little
#python2 ../python/openmpeigenbench_branches.py -r 0.5  -n 4 -b 0  > ./$SRC/tbr05n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 0.7  -n 4 -b 0  > ./$SRC/tbr07n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 0.9  -n 4 -b 0  > ./$SRC/tbr09n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 1  -n 4 -b 0  > ./$SRC/tbr1n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 1.5  -n 4 -b 0  > ./$SRC/tbr1.5n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 2  -n 4 -b 0  > ./$SRC/tbr2n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 2.5  -n 4 -b 0  > ./$SRC/tbr25n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 5  -n 4 -b 0  > ./$SRC/tbr5n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 10  -n 4 -b 0  > ./$SRC/tbr10n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 15  -n 4 -b 0  > ./$SRC/tbr15n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 20  -n 4 -b 0  > ./$SRC/tbr20n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 25  -n 4 -b 0  > ./$SRC/tbr25n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 30  -n 4 -b 0  > ./$SRC/tbr30n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 35  -n 4 -b 0  > ./$SRC/tbr35n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 30  -n 4 -b 0  > ./$SRC/tbr30n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 40  -n 4 -b 0  > ./$SRC/tbr40n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 45  -n 4 -b 0  > ./$SRC/tbr45n4b0.c
#python2 ../python/openmpeigenbench_branches.py -r 50  -n 4 -b 0  > ./$SRC/tbr50n4b0.c



#Cluster Configuration: 4 little and 2 big
#python2 ../python/openmpeigenbench_branches.py -r 0.5  -n 6 -b 2  > ./$SRC/tbr05n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 0.7  -n 6 -b 2  > ./$SRC/tbr07n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 0.9  -n 6 -b 2  > ./$SRC/tbr09n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 1  -n 6 -b 2  > ./$SRC/tbr1n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 1.5  -n 6 -b 2  > ./$SRC/tbr1.5n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 2  -n 6 -b 2  > ./$SRC/tbr2n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 2.5  -n 6 -b 2  > ./$SRC/tbr25n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 5  -n 6 -b 2  > ./$SRC/tbr5n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 10  -n 6 -b 2  > ./$SRC/tbr10n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 15  -n 6 -b 2  > ./$SRC/tbr15n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 20  -n 6 -b 2  > ./$SRC/tbr20n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 25  -n 6 -b 2  > ./$SRC/tbr25n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 30  -n 6 -b 2  > ./$SRC/tbr30n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 35  -n 6 -b 2  > ./$SRC/tbr35n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 30  -n 6 -b 2  > ./$SRC/tbr30n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 40  -n 6 -b 2  > ./$SRC/tbr40n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 45  -n 6 -b 2  > ./$SRC/tbr45n6b2.c
#python2 ../python/openmpeigenbench_branches.py -r 50  -n 6 -b 2  > ./$SRC/tbr50n6b2.c





#Cluster Configuration: 2 big
python2 ../python/openmpeigenbench_branches.py -r 1000  -n 2 -b 2  > ./$SRC/tbr05n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 2000  -n 2 -b 2  > ./$SRC/tbr07n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 3000  -n 2 -b 2  > ./$SRC/tbr09n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 4000  -n 2 -b 2  > ./$SRC/tbr1n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 5000  -n 2 -b 2  > ./$SRC/tbr1.5n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 6000  -n 2 -b 2  > ./$SRC/tbr2n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 7000  -n 2 -b 2  > ./$SRC/tbr25n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 8000  -n 2 -b 2  > ./$SRC/tbr5n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 9000  -n 2 -b 2  > ./$SRC/tbr10n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 10000  -n 2 -b 2  > ./$SRC/tbr15n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 11000  -n 2 -b 2  > ./$SRC/tbr20n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 12000  -n 2 -b 2  > ./$SRC/tbr25n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 13000  -n 2 -b 2  > ./$SRC/tbr30n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 14000  -n 2 -b 2  > ./$SRC/tbr35n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 15000  -n 2 -b 2  > ./$SRC/tbr30n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 16000  -n 2 -b 2  > ./$SRC/tbr40n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 17000  -n 2 -b 2  > ./$SRC/tbr45n2b2.c
python2 ../python/openmpeigenbench_branches.py -r 18000  -n 2 -b 2  > ./$SRC/tbr50n2b2.c


#Cluster Configuration: 4 little
python2 ../python/openmpeigenbench_branches.py -r 1000  -n 4 -b 0  > ./$SRC/tbr05n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 2000  -n 4 -b 0  > ./$SRC/tbr07n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 3000  -n 4 -b 0  > ./$SRC/tbr09n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 4000  -n 4 -b 0  > ./$SRC/tbr1n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 5000  -n 4 -b 0  > ./$SRC/tbr1.5n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 6000  -n 4 -b 0  > ./$SRC/tbr2n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 7000  -n 4 -b 0  > ./$SRC/tbr25n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 8000  -n 4 -b 0  > ./$SRC/tbr5n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 9000  -n 4 -b 0  > ./$SRC/tbr10n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 10000  -n 4 -b 0  > ./$SRC/tbr15n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 11000  -n 4 -b 0  > ./$SRC/tbr20n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 12000  -n 4 -b 0  > ./$SRC/tbr25n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 13000  -n 4 -b 0  > ./$SRC/tbr30n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 14000  -n 4 -b 0  > ./$SRC/tbr35n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 15000  -n 4 -b 0  > ./$SRC/tbr30n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 16000  -n 4 -b 0  > ./$SRC/tbr40n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 17000  -n 4 -b 0  > ./$SRC/tbr45n4b0.c
python2 ../python/openmpeigenbench_branches.py -r 18000  -n 4 -b 0  > ./$SRC/tbr50n4b0.c



#Cluster Configuration: 4 little and 2 big
python2 ../python/openmpeigenbench_branches.py -r 1000  -n 6 -b 2  > ./$SRC/tbr05n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 2000  -n 6 -b 2  > ./$SRC/tbr07n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 3000  -n 6 -b 2  > ./$SRC/tbr09n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 4000  -n 6 -b 2  > ./$SRC/tbr1n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 5000  -n 6 -b 2  > ./$SRC/tbr1.5n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 6000  -n 6 -b 2  > ./$SRC/tbr2n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 7000  -n 6 -b 2  > ./$SRC/tbr25n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 8000  -n 6 -b 2  > ./$SRC/tbr5n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 9000  -n 6 -b 2  > ./$SRC/tbr10n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 10000  -n 6 -b 2  > ./$SRC/tbr15n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 11000  -n 6 -b 2  > ./$SRC/tbr20n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 12000  -n 6 -b 2  > ./$SRC/tbr25n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 13000  -n 6 -b 2  > ./$SRC/tbr30n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 14000  -n 6 -b 2  > ./$SRC/tbr35n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 15000  -n 6 -b 2  > ./$SRC/tbr30n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 16000  -n 6 -b 2  > ./$SRC/tbr40n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 17000  -n 6 -b 2  > ./$SRC/tbr45n6b2.c
python2 ../python/openmpeigenbench_branches.py -r 18000  -n 6 -b 2  > ./$SRC/tbr50n6b2.c
