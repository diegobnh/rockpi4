# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
#
# The above notice shall be included in all copies or substantial
# portions of this file.
SRC=srcfor
rm -r $SRC
mkdir $SRC


python2 ../python/openmpeigenbench_for.py -r 1  -n 6 -b 2  --sched static > ./$SRC/tbr1n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 5  -n 6 -b 2  --sched static > ./$SRC/tbr5n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 10  -n 6 -b 2  --sched static > ./$SRC/tbr10n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 20  -n 6 -b 2  --sched static > ./$SRC/tbr20n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 25  -n 6 -b 2  --sched static > ./$SRC/tbr25n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 50  -n 6 -b 2  --sched static > ./$SRC/tbr50n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 75  -n 6 -b 2  --sched static > ./$SRC/tbr75n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 100  -n 6 -b 2  --sched static > ./$SRC/tbr100n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 200  -n 6 -b 2  --sched static > ./$SRC/tbr200n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 500  -n 6 -b 2  --sched static > ./$SRC/tbr500n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 750  -n 6 -b 2  --sched static > ./$SRC/tbr750n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 1000  -n 6 -b 2  --sched static > ./$SRC/tbr1000n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 2000  -n 6 -b 2  --sched static > ./$SRC/tbr2000n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 4000  -n 6 -b 2  --sched static > ./$SRC/tbr4000n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 8000  -n 6 -b 2  --sched static > ./$SRC/tbr8000n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 16000  -n 6 -b 2  --sched static > ./$SRC/tbr16000n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 32000  -n 6 -b 2  --sched static > ./$SRC/tbr32000n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 64000  -n 6 -b 2  --sched static > ./$SRC/tbr64000n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 128000  -n 6 -b 2  --sched static > ./$SRC/tbr128000n6b2sds.c
python2 ../python/openmpeigenbench_for.py -r 1024000  -n 6 -b 2  --sched static > ./$SRC/tbr1024000n6b2sds.c


python2 ../python/openmpeigenbench_for.py -r 1  -n 4 -b 0  --sched static > ./$SRC/1tbr1n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 5  -n 4 -b 0  --sched static > ./$SRC/1tbr5n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 10  -n 4 -b 0  --sched static > ./$SRC/1tbr10n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 20  -n 4 -b 0  --sched static > ./$SRC/1tbr20n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 25  -n 4 -b 0  --sched static > ./$SRC/1tbr25n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 50  -n 4 -b 0  --sched static > ./$SRC/1tbr50n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 75  -n 4 -b 0  --sched static > ./$SRC/1tbr75n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 100  -n 4 -b 0  --sched static > ./$SRC/1tbr100n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 200  -n 4 -b 0  --sched static > ./$SRC/1tbr200n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 500  -n 4 -b 0  --sched static > ./$SRC/1tbr500n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 750  -n 4 -b 0  --sched static > ./$SRC/1tbr750n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 1000  -n 4 -b 0  --sched static > ./$SRC/1tbr1000n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 2000  -n 4 -b 0  --sched static > ./$SRC/1tbr2000n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 4000  -n 4 -b 0  --sched static > ./$SRC/1tbr4000n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 8000  -n 4 -b 0  --sched static > ./$SRC/1tbr8000n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 16000  -n 4 -b 0  --sched static > ./$SRC/1tbr16000n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 32000  -n 4 -b 0  --sched static > ./$SRC/1tbr32000n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 64000  -n 4 -b 0  --sched static > ./$SRC/1tbr64000n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 128000  -n 4 -b 0  --sched static > ./$SRC/1tbr128n4b0sds.c
python2 ../python/openmpeigenbench_for.py -r 1024000  -n 4 -b 0  --sched static > ./$SRC/1tbr1024000n4b0sds.c


python2 ../python/openmpeigenbench_for.py -r 1  -n 2 -b 2  --sched static > ./$SRC/2tbr1n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 5  -n 2 -b 2  --sched static > ./$SRC/2tbr5n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 10  -n 2 -b 2  --sched static > ./$SRC/2tbr10n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 20  -n 2 -b 2  --sched static > ./$SRC/2tbr20n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 25  -n 2 -b 2  --sched static > ./$SRC/2tbr25n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 50  -n 2 -b 2  --sched static > ./$SRC/2tbr50n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 75  -n 2 -b 2  --sched static > ./$SRC/2tbr75n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 100  -n 2 -b 2  --sched static > ./$SRC/2tbr100n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 200  -n 2 -b 2  --sched static > ./$SRC/2tbr200n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 500  -n 2 -b 2  --sched static > ./$SRC/2tbr500n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 750  -n 2 -b 2  --sched static > ./$SRC/2tbr750n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 1000  -n 2 -b 2  --sched static > ./$SRC/2tbr1000n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 2000  -n 2 -b 2  --sched static > ./$SRC/2tbr2000n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 4000  -n 2 -b 2  --sched static > ./$SRC/2tbr4000n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 8000  -n 2 -b 2  --sched static > ./$SRC/2tbr8000n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 16000  -n 2 -b 2  --sched static > ./$SRC/2tbr16000n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 32000  -n 2 -b 2  --sched static > ./$SRC/2tbr32000n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 64000  -n 2 -b 2  --sched static > ./$SRC/2tbr64000n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 128000  -n 2 -b 2  --sched static > ./$SRC/2tbr128n2b2sds.c
python2 ../python/openmpeigenbench_for.py -r 1024000  -n 2 -b 2  --sched static > ./$SRC/1tbr1024000n2b2sds.c









# python2 ../python/openmpeigenbench_for.py -r 1  -n 8  -b 4  --sched static > ./$SRC/tbr1n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 5  -n 6 -b 2  --sched static > ./$SRC/tbr5n6b2sds.c
# python2 ../python/../python/openmpeigenbench_for.py -r 10  -n 6 -b 2  --sched static > ./$SRC/tbr10n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 20  -n 6 -b 2  --sched static > ./$SRC/tbr20n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 25  -n 6 -b 2  --sched static > ./$SRC/tbr25n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 50  -n 6 -b 2  --sched static > ./$SRC/tbr50n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 75  -n 6 -b 2  --sched static > ./$SRC/tbr75n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 100  -n 6 -b 2  --sched static > ./$SRC/tbr100n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 200  -n 6 -b 2  --sched static > ./$SRC/tbr200n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 500  -n 6 -b 2  --sched static > ./$SRC/tbr500n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 750  -n 6 -b 2  --sched static > ./$SRC/tbr750n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 1000  -n 6 -b 2  --sched static > ./$SRC/tbr1000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 2000  -n 6 -b 2  --sched static > ./$SRC/tbr2000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 4000  -n 6 -b 2  --sched static > ./$SRC/tbr4000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 8000  -n 6 -b 2  --sched static > ./$SRC/tbr8000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 16000  -n 6 -b 2  --sched static > ./$SRC/tbr16000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 32000  -n 6 -b 2  --sched static > ./$SRC/tbr32000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 64000  -n 6 -b 2  --sched static > ./$SRC/tbr64000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 128000  -n 6 -b 2  --sched static > ./$SRC/tbr128000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 1024000  -n 6 -b 2  --sched static > ./$SRC/tbr1024000n6b2sds.c


# python2 ../python/openmpeigenbench_for.py -r 1  -n 6 -b 2  --sched static > ./$SRC/1tbr1n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 5  -n 6 -b 2  --sched static > ./$SRC/1tbr5n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 10  -n 6 -b 2  --sched static > ./$SRC/1tbr10n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 20  -n 6 -b 2  --sched static > ./$SRC/1tbr20n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 25  -n 6 -b 2  --sched static > ./$SRC/1tbr25n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 50  -n 6 -b 2  --sched static > ./$SRC/1tbr50n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 75  -n 6 -b 2  --sched static > ./$SRC/1tbr75n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 100  -n 6 -b 2  --sched static > ./$SRC/1tbr100n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 200  -n 6 -b 2  --sched static > ./$SRC/1tbr200n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 500  -n 6 -b 2  --sched static > ./$SRC/1tbr500n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 750  -n 6 -b 2  --sched static > ./$SRC/1tbr750n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 1000  -n 6 -b 2  --sched static > ./$SRC/1tbr1000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 2000  -n 6 -b 2  --sched static > ./$SRC/1tbr2000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 4000  -n 6 -b 2  --sched static > ./$SRC/1tbr4000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 8000  -n 6 -b 2  --sched static > ./$SRC/1tbr8000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 16000  -n 6 -b 2  --sched static > ./$SRC/1tbr16000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 32000  -n 6 -b 2  --sched static > ./$SRC/1tbr32000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 64000  -n 6 -b 2  --sched static > ./$SRC/1tbr64000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 128000  -n 6 -b 2  --sched static > ./$SRC/1tbr128n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 1024000  -n 6 -b 2  --sched static > ./$SRC/1tbr1024000n6b2sds.c


# python2 ../python/openmpeigenbench_for.py -r 1  -n 6 -b 2  --sched static > ./$SRC/2tbr1n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 5  -n 6 -b 2  --sched static > ./$SRC/2tbr5n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 10  -n 6 -b 2  --sched static > ./$SRC/2tbr10n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 20  -n 6 -b 2  --sched static > ./$SRC/2tbr20n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 25  -n 6 -b 2  --sched static > ./$SRC/2tbr25n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 50  -n 6 -b 2  --sched static > ./$SRC/2tbr50n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 75  -n 6 -b 2  --sched static > ./$SRC/2tbr75n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 100  -n 6 -b 2  --sched static > ./$SRC/2tbr100n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 200  -n 6 -b 2  --sched static > ./$SRC/2tbr200n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 500  -n 6 -b 2  --sched static > ./$SRC/2tbr500n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 750  -n 6 -b 2  --sched static > ./$SRC/2tbr750n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 1000  -n 6 -b 2  --sched static > ./$SRC/2tbr1000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 2000  -n 6 -b 2  --sched static > ./$SRC/2tbr2000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 4000  -n 6 -b 2  --sched static > ./$SRC/2tbr4000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 8000  -n 6 -b 2  --sched static > ./$SRC/2tbr8000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 16000  -n 6 -b 2  --sched static > ./$SRC/2tbr16000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 32000  -n 6 -b 2  --sched static > ./$SRC/2tbr32000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 64000  -n 6 -b 2  --sched static > ./$SRC/2tbr64000n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 128000  -n 6 -b 2  --sched static > ./$SRC/2tbr128n6b2sds.c
# python2 ../python/openmpeigenbench_for.py -r 1024000  -n 6 -b 2  --sched static > ./$SRC/1tbr1024000n6b2sds.c
