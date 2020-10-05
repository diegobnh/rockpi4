# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
#
# The above notice shall be included in all copies or substantial
# portions of this file.
SRC=srcdependence
rm -r $SRC
mkdir $SRC

#Cluster Configuration: 2 big
#python2 ../python/openmpeigenbench_dependence.py -m 10  -n 2 -b 2  > ./$SRC/tmem10n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 15  -n 2 -b 2  > ./$SRC/tmem15n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 20  -n 2 -b 2  > ./$SRC/tmem20n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 25  -n 2 -b 2  > ./$SRC/tmem25n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 30  -n 2 -b 2  > ./$SRC/tmem30n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 35  -n 2 -b 2  > ./$SRC/tmem35n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 30  -n 2 -b 2  > ./$SRC/tmem30n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 40  -n 2 -b 2  > ./$SRC/tmem40n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 45  -n 2 -b 2  > ./$SRC/tmem45n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 50  -n 2 -b 2  > ./$SRC/tmem50n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 55  -n 2 -b 2  > ./$SRC/tmem55n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 60  -n 2 -b 2  > ./$SRC/tmem60n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 65  -n 2 -b 2  > ./$SRC/tmem65n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 70  -n 2 -b 2  > ./$SRC/tmem70n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 75  -n 2 -b 2  > ./$SRC/tmem75n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 80  -n 2 -b 2  > ./$SRC/tmem80n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 90  -n 2 -b 2  > ./$SRC/tmem90n2b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 100  -n 2 -b 2  > ./$SRC/tmem100n2b2.c


#Cluster Configuration: 4 little
#python2 ../python/openmpeigenbench_dependence.py -m 10  -n 4 -b 0  > ./$SRC/tmem10n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 15  -n 4 -b 0  > ./$SRC/tmem15n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 20  -n 4 -b 0  > ./$SRC/tmem20n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 25  -n 4 -b 0  > ./$SRC/tmem25n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 30  -n 4 -b 0  > ./$SRC/tmem30n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 35  -n 4 -b 0  > ./$SRC/tmem35n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 30  -n 4 -b 0  > ./$SRC/tmem30n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 40  -n 4 -b 0  > ./$SRC/tmem40n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 45  -n 4 -b 0  > ./$SRC/tmem45n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 50  -n 4 -b 0  > ./$SRC/tmem50n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 55  -n 4 -b 0  > ./$SRC/tmem55n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 60  -n 4 -b 0  > ./$SRC/tmem60n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 65  -n 4 -b 0  > ./$SRC/tmem65n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 70  -n 4 -b 0  > ./$SRC/tmem70n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 75  -n 4 -b 0  > ./$SRC/tmem75n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 80  -n 4 -b 0  > ./$SRC/tmem80n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 90  -n 4 -b 0  > ./$SRC/tmem90n4b0.c
#python2 ../python/openmpeigenbench_dependence.py -m 100  -n 4 -b 0  > ./$SRC/tmem100n4b0.c


#Cluster Configuration: 4 little and 2 big
#python2 ../python/openmpeigenbench_dependence.py -m 10  -n 6 -b 2  > ./$SRC/tmem10n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 15  -n 6 -b 2  > ./$SRC/tmem15n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 20  -n 6 -b 2  > ./$SRC/tmem20n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 25  -n 6 -b 2  > ./$SRC/tmem25n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 30  -n 6 -b 2  > ./$SRC/tmem30n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 35  -n 6 -b 2  > ./$SRC/tmem35n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 30  -n 6 -b 2  > ./$SRC/tmem30n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 40  -n 6 -b 2  > ./$SRC/tmem40n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 45  -n 6 -b 2  > ./$SRC/tmem45n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 50  -n 6 -b 2  > ./$SRC/tmem50n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 55  -n 6 -b 2  > ./$SRC/tmem55n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 60  -n 6 -b 2  > ./$SRC/tmem60n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 65  -n 6 -b 2  > ./$SRC/tmem65n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 70  -n 6 -b 2  > ./$SRC/tmem70n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 75  -n 6 -b 2  > ./$SRC/tmem75n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 80  -n 6 -b 2  > ./$SRC/tmem80n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 90  -n 6 -b 2  > ./$SRC/tmem90n6b2.c
#python2 ../python/openmpeigenbench_dependence.py -m 100  -n 6 -b 2  > ./$SRC/tmem100n6b2.c







#Cluster Configuration: 2 big
python2 ../python/openmpeigenbench_dependence.py -m 100  -n 2 -b 2  > ./$SRC/tmem10n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 200  -n 2 -b 2  > ./$SRC/tmem15n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 300  -n 2 -b 2  > ./$SRC/tmem20n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 400  -n 2 -b 2  > ./$SRC/tmem25n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 500  -n 2 -b 2  > ./$SRC/tmem30n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 600  -n 2 -b 2  > ./$SRC/tmem35n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 700  -n 2 -b 2  > ./$SRC/tmem30n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 800  -n 2 -b 2  > ./$SRC/tmem40n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 900  -n 2 -b 2  > ./$SRC/tmem45n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1000  -n 2 -b 2  > ./$SRC/tmem50n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1100  -n 2 -b 2  > ./$SRC/tmem55n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1200  -n 2 -b 2  > ./$SRC/tmem60n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1300  -n 2 -b 2  > ./$SRC/tmem65n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1400  -n 2 -b 2  > ./$SRC/tmem70n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1500  -n 2 -b 2  > ./$SRC/tmem75n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1600  -n 2 -b 2  > ./$SRC/tmem80n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1700  -n 2 -b 2  > ./$SRC/tmem90n2b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1800  -n 2 -b 2  > ./$SRC/tmem100n2b2.c


#Cluster Configuration: 4 little
python2 ../python/openmpeigenbench_dependence.py -m 100  -n 4 -b 0  > ./$SRC/tmem10n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 200  -n 4 -b 0  > ./$SRC/tmem15n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 300  -n 4 -b 0  > ./$SRC/tmem20n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 400  -n 4 -b 0  > ./$SRC/tmem25n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 500  -n 4 -b 0  > ./$SRC/tmem30n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 600  -n 4 -b 0  > ./$SRC/tmem35n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 700  -n 4 -b 0  > ./$SRC/tmem30n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 800  -n 4 -b 0  > ./$SRC/tmem40n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 900  -n 4 -b 0  > ./$SRC/tmem45n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 1000  -n 4 -b 0  > ./$SRC/tmem50n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 1100  -n 4 -b 0  > ./$SRC/tmem55n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 1200  -n 4 -b 0  > ./$SRC/tmem60n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 1300  -n 4 -b 0  > ./$SRC/tmem65n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 1400  -n 4 -b 0  > ./$SRC/tmem70n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 1500  -n 4 -b 0  > ./$SRC/tmem75n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 1600  -n 4 -b 0  > ./$SRC/tmem80n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 1700  -n 4 -b 0  > ./$SRC/tmem90n4b0.c
python2 ../python/openmpeigenbench_dependence.py -m 1800  -n 4 -b 0  > ./$SRC/tmem100n4b0.c


#Cluster Configuration: 4 little and 2 big
python2 ../python/openmpeigenbench_dependence.py -m 100  -n 6 -b 2  > ./$SRC/tmem10n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 200  -n 6 -b 2  > ./$SRC/tmem15n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 300  -n 6 -b 2  > ./$SRC/tmem20n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 400  -n 6 -b 2  > ./$SRC/tmem25n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 500  -n 6 -b 2  > ./$SRC/tmem30n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 600  -n 6 -b 2  > ./$SRC/tmem35n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 700  -n 6 -b 2  > ./$SRC/tmem30n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 800  -n 6 -b 2  > ./$SRC/tmem40n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 900  -n 6 -b 2  > ./$SRC/tmem45n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1000  -n 6 -b 2  > ./$SRC/tmem50n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1100  -n 6 -b 2  > ./$SRC/tmem55n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1200  -n 6 -b 2  > ./$SRC/tmem60n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1300  -n 6 -b 2  > ./$SRC/tmem65n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1400  -n 6 -b 2  > ./$SRC/tmem70n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1500  -n 6 -b 2  > ./$SRC/tmem75n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1600  -n 6 -b 2  > ./$SRC/tmem80n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1700  -n 6 -b 2  > ./$SRC/tmem90n6b2.c
python2 ../python/openmpeigenbench_dependence.py -m 1800  -n 6 -b 2  > ./$SRC/tmem100n6b2.c
