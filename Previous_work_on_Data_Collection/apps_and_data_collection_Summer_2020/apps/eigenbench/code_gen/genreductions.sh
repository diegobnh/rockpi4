# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
#
# The above notice shall be included in all copies or substantial
# portions of this file.
SRC=srcreductions
rm -r $SRC
mkdir $SRC

#Cluster Configuration: 2 big
python2 ../python/openmpeigenbench_reductions.py -r 5  -n 2 -b 2  > ./$SRC/trd01n2b2.c
python2 ../python/openmpeigenbench_reductions.py -r 10  -n 2 -b 2  > ./$SRC/trd02n2b2.c
python2 ../python/openmpeigenbench_reductions.py -r 15  -n 2 -b 2  > ./$SRC/trd03n2b2.c
python2 ../python/openmpeigenbench_reductions.py -r 20  -n 2 -b 2  > ./$SRC/trd05n2b2.c
python2 ../python/openmpeigenbench_reductions.py -r 25  -n 2 -b 2  > ./$SRC/trd07n2b2.c
python2 ../python/openmpeigenbench_reductions.py -r 30  -n 2 -b 2  > ./$SRC/trd09n2b2.c
python2 ../python/openmpeigenbench_reductions.py -r 35  -n 2 -b 2  > ./$SRC/trd1n2b2.c
python2 ../python/openmpeigenbench_reductions.py -r 40  -n 2 -b 2  > ./$SRC/trd1.5n2b2.c
python2 ../python/openmpeigenbench_reductions.py -r 45  -n 2 -b 2  > ./$SRC/trd2n2b2.c
python2 ../python/openmpeigenbench_reductions.py -r 50  -n 2 -b 2  > ./$SRC/trd25n2b2.c
python2 ../python/openmpeigenbench_reductions.py -r 55  -n 2 -b 2  > ./$SRC/trd5n2b2.c
python2 ../python/openmpeigenbench_reductions.py -r 60  -n 2 -b 2  > ./$SRC/trd10n2b2.c
python2 ../python/openmpeigenbench_reductions.py -r 65  -n 2 -b 2  > ./$SRC/trd15n2b2.c
python2 ../python/openmpeigenbench_reductions.py -r 70  -n 2 -b 2  > ./$SRC/trd20n2b2.c
python2 ../python/openmpeigenbench_reductions.py -r 75  -n 2 -b 2  > ./$SRC/trd25n2b2.c
python2 ../python/openmpeigenbench_reductions.py -r 80  -n 2 -b 2  > ./$SRC/trd30n2b2.c
python2 ../python/openmpeigenbench_reductions.py -r 85  -n 2 -b 2  > ./$SRC/trd35n2b2.c


#Cluster Configuration: 4 little
python2 ../python/openmpeigenbench_reductions.py -r 5  -n 4 -b 0 > ./$SRC/trd01n4b0.c
python2 ../python/openmpeigenbench_reductions.py -r 10  -n 4 -b 0 > ./$SRC/trd02n4b0.c
python2 ../python/openmpeigenbench_reductions.py -r 15  -n 4 -b 0 > ./$SRC/trd03n4b0.c
python2 ../python/openmpeigenbench_reductions.py -r 20  -n 4 -b 0 > ./$SRC/trd05n4b0.c
python2 ../python/openmpeigenbench_reductions.py -r 25  -n 4 -b 0 > ./$SRC/trd07n4b0.c
python2 ../python/openmpeigenbench_reductions.py -r 30  -n 4 -b 0 > ./$SRC/trd09n4b0.c
python2 ../python/openmpeigenbench_reductions.py -r 35  -n 4 -b 0 > ./$SRC/trd1n4b0.c
python2 ../python/openmpeigenbench_reductions.py -r 40  -n 4 -b 0 > ./$SRC/trd1.5n4b0.c
python2 ../python/openmpeigenbench_reductions.py -r 45  -n 4 -b 0 > ./$SRC/trd2n4b0.c
python2 ../python/openmpeigenbench_reductions.py -r 50  -n 4 -b 0 > ./$SRC/trd25n4b0.c
python2 ../python/openmpeigenbench_reductions.py -r 55  -n 4 -b 0 > ./$SRC/trd5n4b0.c
python2 ../python/openmpeigenbench_reductions.py -r 60  -n 4 -b 0 > ./$SRC/trd10n4b0.c
python2 ../python/openmpeigenbench_reductions.py -r 65  -n 4 -b 0 > ./$SRC/trd15n4b0.c
python2 ../python/openmpeigenbench_reductions.py -r 70  -n 4 -b 0 > ./$SRC/trd20n4b0.c
python2 ../python/openmpeigenbench_reductions.py -r 75  -n 4 -b 0 > ./$SRC/trd25n4b0.c
python2 ../python/openmpeigenbench_reductions.py -r 80  -n 4 -b 0 > ./$SRC/trd30n4b0.c
python2 ../python/openmpeigenbench_reductions.py -r 85  -n 4 -b 0 > ./$SRC/trd35n4b0.c


#Cluster Configuration: 4 little and 2 big
python2 ../python/openmpeigenbench_reductions.py -r 5  -n 6 -b 2 > ./$SRC/trd01n6b2.c
python2 ../python/openmpeigenbench_reductions.py -r 10  -n 6 -b 2 > ./$SRC/trd02n6b2.c
python2 ../python/openmpeigenbench_reductions.py -r 15  -n 6 -b 2 > ./$SRC/trd03n6b2.c
python2 ../python/openmpeigenbench_reductions.py -r 20  -n 6 -b 2 > ./$SRC/trd05n6b2.c
python2 ../python/openmpeigenbench_reductions.py -r 25  -n 6 -b 2 > ./$SRC/trd07n6b2.c
python2 ../python/openmpeigenbench_reductions.py -r 30  -n 6 -b 2 > ./$SRC/trd09n6b2.c
python2 ../python/openmpeigenbench_reductions.py -r 35  -n 6 -b 2 > ./$SRC/trd1n6b2.c
python2 ../python/openmpeigenbench_reductions.py -r 40  -n 6 -b 2 > ./$SRC/trd1.5n6b2.c
python2 ../python/openmpeigenbench_reductions.py -r 45  -n 6 -b 2 > ./$SRC/trd2n6b2.c
python2 ../python/openmpeigenbench_reductions.py -r 50  -n 6 -b 2 > ./$SRC/trd25n6b2.c
python2 ../python/openmpeigenbench_reductions.py -r 55  -n 6 -b 2 > ./$SRC/trd5n6b2.c
python2 ../python/openmpeigenbench_reductions.py -r 60  -n 6 -b 2 > ./$SRC/trd10n6b2.c
python2 ../python/openmpeigenbench_reductions.py -r 65  -n 6 -b 2 > ./$SRC/trd15n6b2.c
python2 ../python/openmpeigenbench_reductions.py -r 70  -n 6 -b 2 > ./$SRC/trd20n6b2.c
python2 ../python/openmpeigenbench_reductions.py -r 75  -n 6 -b 2 > ./$SRC/trd25n6b2.c
python2 ../python/openmpeigenbench_reductions.py -r 80  -n 6 -b 2 > ./$SRC/trd30n6b2.c
python2 ../python/openmpeigenbench_reductions.py -r 85  -n 6 -b 2 > ./$SRC/trd35n6b2.c
