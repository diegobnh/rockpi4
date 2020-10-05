# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
SRC=srccritical
rm -r $SRC
mkdir $SRC

python openmpeigenbench_critical.py -c 0.1  -n 4 -b 2  > ./$SRC/tcr01n4b2.c
python openmpeigenbench_critical.py -c 0.2  -n 4 -b 2  > ./$SRC/tcr02n4b2.c
python openmpeigenbench_critical.py -c 0.3  -n 4 -b 2  > ./$SRC/tcr03n4b2.c
python openmpeigenbench_critical.py -c 0.5  -n 4 -b 2  > ./$SRC/tcr05n4b2.c
python openmpeigenbench_critical.py -c 0.7  -n 4 -b 2  > ./$SRC/tcr07n4b2.c
python openmpeigenbench_critical.py -c 0.9  -n 4 -b 2  > ./$SRC/tcr09n4b2.c
python openmpeigenbench_critical.py -c 1  -n 4 -b 2  > ./$SRC/tcr1n4b2.c
python openmpeigenbench_critical.py -c 1.5  -n 4 -b 2  > ./$SRC/tcr1.5n4b2.c
python openmpeigenbench_critical.py -c 2  -n 4 -b 2  > ./$SRC/tcr2n4b2.c
python openmpeigenbench_critical.py -c 2.5  -n 4 -b 2  > ./$SRC/tcr25n4b2.c
python openmpeigenbench_critical.py -c 5  -n 4 -b 2  > ./$SRC/tcr5n4b2.c
python openmpeigenbench_critical.py -c 10  -n 4 -b 2  > ./$SRC/tcr10n4b2.c
python openmpeigenbench_critical.py -c 15  -n 4 -b 2  > ./$SRC/tcr15n4b2.c
python openmpeigenbench_critical.py -c 20  -n 4 -b 2  > ./$SRC/tcr20n4b2.c
python openmpeigenbench_critical.py -c 25  -n 4 -b 2  > ./$SRC/tcr25n4b2.c
python openmpeigenbench_critical.py -c 30  -n 4 -b 2  > ./$SRC/tcr30n4b2.c
python openmpeigenbench_critical.py -c 35  -n 4 -b 2  > ./$SRC/tcr35n4b2.c
python openmpeigenbench_critical.py -c 30  -n 4 -b 2  > ./$SRC/tcr30n4b2.c

