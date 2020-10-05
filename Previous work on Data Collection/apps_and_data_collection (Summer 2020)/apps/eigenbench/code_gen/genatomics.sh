# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
#
# The above notice shall be included in all copies or substantial
# portions of this file.
rm -r srcatomics
mkdir srcatomics
SRC=srcatomics

#Old inputs

#Cluster Configuration: 2 big
#python2 ../python/openmpeigenbench_atomics.py -a 0.1  -n 2 -b 2  > ./$SRC/tat01n2b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.2  -n 2 -b 2  > ./$SRC/tat02n2b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.3  -n 2 -b 2  > ./$SRC/tat03n2b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.4  -n 2 -b 2  > ./$SRC/tat04n2b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.5  -n 2 -b 2  > ./$SRC/tat05n2b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.7  -n 2 -b 2  > ./$SRC/tat07n2b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.9  -n 2 -b 2  > ./$SRC/tat09n2b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 1  -n 2 -b 2  > ./$SRC/tat1n2b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 1.5  -n 2 -b 2  > ./$SRC/tat1.5n2b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 2  -n 2 -b 2  > ./$SRC/tat2n2b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 2.5  -n 2 -b 2  > ./$SRC/tat25n2b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 5  -n 2 -b 2  > ./$SRC/tat5n2b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 10  -n 2 -b 2  > ./$SRC/tat10n2b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 15  -n 2 -b 2  > ./$SRC/tat15n2b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 20  -n 2 -b 2  > ./$SRC/tat20n2b2.c




#Cluster Configuration: 4 little
#python2 ../python/openmpeigenbench_atomics.py -a 0.1  -n 4 -b 0  > ./$SRC/tat01n4b0.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.2  -n 4 -b 0  > ./$SRC/tat02n4b0.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.3  -n 4 -b 0  > ./$SRC/tat03n4b0.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.4  -n 4 -b 0  > ./$SRC/tat04n4b0.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.5  -n 4 -b 0  > ./$SRC/tat05n4b0.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.7  -n 4 -b 0  > ./$SRC/tat07n4b0.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.9  -n 4 -b 0  > ./$SRC/tat09n4b0.c
#python2 ../python/openmpeigenbench_atomics.py -a 1  -n 4 -b 0  > ./$SRC/tat1n4b0.c
#python2 ../python/openmpeigenbench_atomics.py -a 1.5  -n 4 -b 0  > ./$SRC/tat1.5n4b0.c
#python2 ../python/openmpeigenbench_atomics.py -a 2  -n 4 -b 0  > ./$SRC/tat2n4b0.c
#python2 ../python/openmpeigenbench_atomics.py -a 2.5  -n 4 -b 0  > ./$SRC/tat25n4b0.c
#python2 ../python/openmpeigenbench_atomics.py -a 5  -n 4 -b 0  > ./$SRC/tat5n4b0.c
#python2 ../python/openmpeigenbench_atomics.py -a 10  -n 4 -b 0  > ./$SRC/tat10n4b0.c
#python2 ../python/openmpeigenbench_atomics.py -a 15  -n 4 -b 0  > ./$SRC/tat15n4b0.c
#python2 ../python/openmpeigenbench_atomics.py -a 20  -n 4 -b 0  > ./$SRC/tat20n4b0.c



#Cluster Configuration: 4 little and 2 big
#python2 ../python/openmpeigenbench_atomics.py -a 0.1  -n 6 -b 2  > ./$SRC/tat01n6b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.2  -n 6 -b 2  > ./$SRC/tat02n6b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.3  -n 6 -b 2  > ./$SRC/tat03n6b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.4  -n 6 -b 2  > ./$SRC/tat04n6b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.5  -n 6 -b 2  > ./$SRC/tat05n6b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.7  -n 6 -b 2  > ./$SRC/tat07n6b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 0.9  -n 6 -b 2  > ./$SRC/tat09n6b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 1  -n 6 -b 2  > ./$SRC/tat1n6b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 1.5  -n 6 -b 2  > ./$SRC/tat1.5n6b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 2  -n 6 -b 2  > ./$SRC/tat2n6b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 2.5  -n 6 -b 2  > ./$SRC/tat25n6b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 5  -n 6 -b 2  > ./$SRC/tat5n6b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 10  -n 6 -b 2  > ./$SRC/tat10n6b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 15  -n 6 -b 2  > ./$SRC/tat15n6b2.c
#python2 ../python/openmpeigenbench_atomics.py -a 20  -n 6 -b 2  > ./$SRC/tat20n6b2.c


#New inputs

#Cluster Configuration: 2 big
python2 ../python/openmpeigenbench_atomics.py -a 10  -n 2 -b 2  > ./$SRC/tat01n2b2.c
python2 ../python/openmpeigenbench_atomics.py -a 20  -n 2 -b 2  > ./$SRC/tat02n2b2.c
python2 ../python/openmpeigenbench_atomics.py -a 30  -n 2 -b 2  > ./$SRC/tat03n2b2.c
python2 ../python/openmpeigenbench_atomics.py -a 40  -n 2 -b 2  > ./$SRC/tat04n2b2.c
python2 ../python/openmpeigenbench_atomics.py -a 50  -n 2 -b 2  > ./$SRC/tat05n2b2.c
python2 ../python/openmpeigenbench_atomics.py -a 60  -n 2 -b 2  > ./$SRC/tat07n2b2.c
python2 ../python/openmpeigenbench_atomics.py -a 70  -n 2 -b 2  > ./$SRC/tat09n2b2.c
python2 ../python/openmpeigenbench_atomics.py -a 80  -n 2 -b 2  > ./$SRC/tat1n2b2.c
python2 ../python/openmpeigenbench_atomics.py -a 90  -n 2 -b 2  > ./$SRC/tat1.5n2b2.c
python2 ../python/openmpeigenbench_atomics.py -a 100  -n 2 -b 2  > ./$SRC/tat2n2b2.c
python2 ../python/openmpeigenbench_atomics.py -a 110  -n 2 -b 2  > ./$SRC/tat25n2b2.c
python2 ../python/openmpeigenbench_atomics.py -a 120  -n 2 -b 2  > ./$SRC/tat5n2b2.c
python2 ../python/openmpeigenbench_atomics.py -a 130  -n 2 -b 2  > ./$SRC/tat10n2b2.c
python2 ../python/openmpeigenbench_atomics.py -a 140  -n 2 -b 2  > ./$SRC/tat15n2b2.c
python2 ../python/openmpeigenbench_atomics.py -a 150  -n 2 -b 2  > ./$SRC/tat20n2b2.c




#Cluster Configuration: 4 little
python2 ../python/openmpeigenbench_atomics.py -a 10  -n 4 -b 0  > ./$SRC/tat01n4b0.c
python2 ../python/openmpeigenbench_atomics.py -a 20  -n 4 -b 0  > ./$SRC/tat02n4b0.c
python2 ../python/openmpeigenbench_atomics.py -a 30  -n 4 -b 0  > ./$SRC/tat03n4b0.c
python2 ../python/openmpeigenbench_atomics.py -a 40  -n 4 -b 0  > ./$SRC/tat04n4b0.c
python2 ../python/openmpeigenbench_atomics.py -a 50  -n 4 -b 0  > ./$SRC/tat05n4b0.c
python2 ../python/openmpeigenbench_atomics.py -a 60  -n 4 -b 0  > ./$SRC/tat07n4b0.c
python2 ../python/openmpeigenbench_atomics.py -a 70  -n 4 -b 0  > ./$SRC/tat09n4b0.c
python2 ../python/openmpeigenbench_atomics.py -a 80  -n 4 -b 0  > ./$SRC/tat1n4b0.c
python2 ../python/openmpeigenbench_atomics.py -a 90  -n 4 -b 0  > ./$SRC/tat1.5n4b0.c
python2 ../python/openmpeigenbench_atomics.py -a 100  -n 4 -b 0  > ./$SRC/tat2n4b0.c
python2 ../python/openmpeigenbench_atomics.py -a 110  -n 4 -b 0  > ./$SRC/tat25n4b0.c
python2 ../python/openmpeigenbench_atomics.py -a 120  -n 4 -b 0  > ./$SRC/tat5n4b0.c
python2 ../python/openmpeigenbench_atomics.py -a 130  -n 4 -b 0  > ./$SRC/tat10n4b0.c
python2 ../python/openmpeigenbench_atomics.py -a 140  -n 4 -b 0  > ./$SRC/tat15n4b0.c
python2 ../python/openmpeigenbench_atomics.py -a 150  -n 4 -b 0  > ./$SRC/tat20n4b0.c



#Cluster Configuration: 4 little and 2 big
python2 ../python/openmpeigenbench_atomics.py -a 10  -n 6 -b 2  > ./$SRC/tat01n6b2.c
python2 ../python/openmpeigenbench_atomics.py -a 20  -n 6 -b 2  > ./$SRC/tat02n6b2.c
python2 ../python/openmpeigenbench_atomics.py -a 30  -n 6 -b 2  > ./$SRC/tat03n6b2.c
python2 ../python/openmpeigenbench_atomics.py -a 40  -n 6 -b 2  > ./$SRC/tat04n6b2.c
python2 ../python/openmpeigenbench_atomics.py -a 50  -n 6 -b 2  > ./$SRC/tat05n6b2.c
python2 ../python/openmpeigenbench_atomics.py -a 60  -n 6 -b 2  > ./$SRC/tat07n6b2.c
python2 ../python/openmpeigenbench_atomics.py -a 70  -n 6 -b 2  > ./$SRC/tat09n6b2.c
python2 ../python/openmpeigenbench_atomics.py -a 80  -n 6 -b 2  > ./$SRC/tat1n6b2.c
python2 ../python/openmpeigenbench_atomics.py -a 90  -n 6 -b 2  > ./$SRC/tat1.5n6b2.c
python2 ../python/openmpeigenbench_atomics.py -a 100  -n 6 -b 2  > ./$SRC/tat2n6b2.c
python2 ../python/openmpeigenbench_atomics.py -a 110  -n 6 -b 2  > ./$SRC/tat25n6b2.c
python2 ../python/openmpeigenbench_atomics.py -a 120  -n 6 -b 2  > ./$SRC/tat5n6b2.c
python2 ../python/openmpeigenbench_atomics.py -a 130  -n 6 -b 2  > ./$SRC/tat10n6b2.c
python2 ../python/openmpeigenbench_atomics.py -a 140  -n 6 -b 2  > ./$SRC/tat15n6b2.c
python2 ../python/openmpeigenbench_atomics.py -a 150  -n 6 -b 2  > ./$SRC/tat20n6b2.c
