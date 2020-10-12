# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
SRC=srcbranches
rm -r $SRC
mkdir $SRC

python openmpeigenbench_branches.py -r 0.5  -n 4 -b 2  > ./$SRC/tbr05n4b2.c
python openmpeigenbench_branches.py -r 0.7  -n 4 -b 2  > ./$SRC/tbr07n4b2.c
python openmpeigenbench_branches.py -r 0.9  -n 4 -b 2  > ./$SRC/tbr09n4b2.c
python openmpeigenbench_branches.py -r 1  -n 4 -b 2  > ./$SRC/tbr1n4b2.c
python openmpeigenbench_branches.py -r 1.5  -n 4 -b 2  > ./$SRC/tbr1.5n4b2.c
python openmpeigenbench_branches.py -r 2  -n 4 -b 2  > ./$SRC/tbr2n4b2.c
python openmpeigenbench_branches.py -r 2.5  -n 4 -b 2  > ./$SRC/tbr25n4b2.c
python openmpeigenbench_branches.py -r 5  -n 4 -b 2  > ./$SRC/tbr5n4b2.c
python openmpeigenbench_branches.py -r 10  -n 4 -b 2  > ./$SRC/tbr10n4b2.c
python openmpeigenbench_branches.py -r 15  -n 4 -b 2  > ./$SRC/tbr15n4b2.c
python openmpeigenbench_branches.py -r 20  -n 4 -b 2  > ./$SRC/tbr20n4b2.c
python openmpeigenbench_branches.py -r 25  -n 4 -b 2  > ./$SRC/tbr25n4b2.c
python openmpeigenbench_branches.py -r 30  -n 4 -b 2  > ./$SRC/tbr30n4b2.c
python openmpeigenbench_branches.py -r 35  -n 4 -b 2  > ./$SRC/tbr35n4b2.c
python openmpeigenbench_branches.py -r 30  -n 4 -b 2  > ./$SRC/tbr30n4b2.c
python openmpeigenbench_branches.py -r 40  -n 4 -b 2  > ./$SRC/tbr40n4b2.c
python openmpeigenbench_branches.py -r 45  -n 4 -b 2  > ./$SRC/tbr45n4b2.c
python openmpeigenbench_branches.py -r 50  -n 4 -b 2  > ./$SRC/tbr50n4b2.c

