# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
#
# The above notice shall be included in all copies or substantial
# portions of this file.
SRC=srcfalsestride
rm -r $SRC
mkdir $SRC

#Cluster Configuration: 4 little
python2 ../python/openmpeigenbench_falsememstride.py -r 1  -n 4 -b 0  > ./$SRC/tstrid1n4b0.c
python2 ../python/openmpeigenbench_falsememstride.py -r 2  -n 4 -b 0  > ./$SRC/tstrid2n4b0.c
python2 ../python/openmpeigenbench_falsememstride.py -r 3  -n 4 -b 0  > ./$SRC/tstrid3n4b0.c
python2 ../python/openmpeigenbench_falsememstride.py -r 4  -n 4 -b 0  > ./$SRC/tstrid4n4b0.c

#Cluster Configuration: 2 big
python2 ../python/openmpeigenbench_falsememstride.py -r 1  -n 2 -b 2  > ./$SRC/tstrid1n2b2.c
python2 ../python/openmpeigenbench_falsememstride.py -r 2  -n 2 -b 2  > ./$SRC/tstrid2n2b2.c
python2 ../python/openmpeigenbench_falsememstride.py -r 3  -n 2 -b 2  > ./$SRC/tstrid3n2b2.c
python2 ../python/openmpeigenbench_falsememstride.py -r 4  -n 2 -b 2  > ./$SRC/tstrid4n2b2.c

#Cluster Configuration: 4 little and 2 big
python2 ../python/openmpeigenbench_falsememstride.py -r 1  -n 6 -b 2  > ./$SRC/tstrid1n6b2.c
python2 ../python/openmpeigenbench_falsememstride.py -r 2  -n 6 -b 2  > ./$SRC/tstrid2n6b2.c
python2 ../python/openmpeigenbench_falsememstride.py -r 3  -n 6 -b 2  > ./$SRC/tstrid3n6b2.c
python2 ../python/openmpeigenbench_falsememstride.py -r 4  -n 6 -b 2  > ./$SRC/tstrid4n6b2.c
