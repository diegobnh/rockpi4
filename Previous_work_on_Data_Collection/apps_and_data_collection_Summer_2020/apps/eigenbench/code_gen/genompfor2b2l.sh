# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
SRC=srcfor
rm -r $SRC
mkdir $SRC



python openmpeigenbench_for.py -r 0.5  -n 4 -b 2  --sched dynamic > ./$SRC/tbr05n4b2sdd.c
python openmpeigenbench_for.py -r 0.7  -n 4 -b 2  --sched dynamic > ./$SRC/tbr07n4b2sdd.c
python openmpeigenbench_for.py -r 0.9  -n 4 -b 2  --sched dynamic > ./$SRC/tbr09n4b2sdd.c
python openmpeigenbench_for.py -r 1  -n 4 -b 2  --sched dynamic > ./$SRC/tbr1n4b2sdd.c
python openmpeigenbench_for.py -r 1.5  -n 4 -b 2  --sched dynamic > ./$SRC/tbr1.5n4b2sdd.c
python openmpeigenbench_for.py -r 2  -n 4 -b 2  --sched dynamic > ./$SRC/tbr2n4b2sdd.c
python openmpeigenbench_for.py -r 2.5  -n 4 -b 2  --sched dynamic > ./$SRC/tbr2.5n4b2sdd.c
python openmpeigenbench_for.py -r 5  -n 4 -b 2  --sched dynamic > ./$SRC/tbr5n4b2sdd.c
python openmpeigenbench_for.py -r 10  -n 4 -b 2  --sched dynamic > ./$SRC/tbr10n4b2sdd.c
python openmpeigenbench_for.py -r 15  -n 4 -b 2  --sched dynamic > ./$SRC/tbr15n4b2sdd.c
python openmpeigenbench_for.py -r 20  -n 4 -b 2  --sched dynamic > ./$SRC/tbr20n4b2sdd.c
