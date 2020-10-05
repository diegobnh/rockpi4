# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
SRC=srcflush
rm -r $SRC
mkdir $SRC

python openmpeigenbench_flush.py -f 0.10  -n 4 -b 2  > ./$SRC/tflus10n4b2.c
python openmpeigenbench_flush.py -f 0.20  -n 4 -b 2  > ./$SRC/tflus20n4b2.c
python openmpeigenbench_flush.py -f 0.30  -n 4 -b 2  > ./$SRC/tflus30n4b2.c
python openmpeigenbench_flush.py -f 0.40  -n 4 -b 2  > ./$SRC/tflus40n4b2.c
python openmpeigenbench_flush.py -f 0.50  -n 4 -b 2  > ./$SRC/tflus50n4b2.c
python openmpeigenbench_flush.py -f 0.60  -n 4 -b 2  > ./$SRC/tflus60n4b2.c
python openmpeigenbench_flush.py -f 0.70  -n 4 -b 2  > ./$SRC/tflus70n4b2.c
python openmpeigenbench_flush.py -f 0.80  -n 4 -b 2  > ./$SRC/tflus80n4b2.c
python openmpeigenbench_flush.py -f 0.90  -n 4 -b 2  > ./$SRC/tflus90n4b2.c
python openmpeigenbench_flush.py -f 1.00  -n 4 -b 2  > ./$SRC/tflus100n4b2.c
python openmpeigenbench_flush.py -f 2.00  -n 4 -b 2  > ./$SRC/tflus200n4b2.c
python openmpeigenbench_flush.py -f 3.00  -n 4 -b 2  > ./$SRC/tflus300n4b2.c
python openmpeigenbench_flush.py -f 4.00  -n 4 -b 2  > ./$SRC/tflus400n4b2.c
python openmpeigenbench_flush.py -f 5.00  -n 4 -b 2  > ./$SRC/tflus500n4b2.c
python openmpeigenbench_flush.py -f 6.00  -n 4 -b 2  > ./$SRC/tflus600n4b2.c
python openmpeigenbench_flush.py -f 7.00  -n 4 -b 2  > ./$SRC/tflus700n4b2.c
python openmpeigenbench_flush.py -f 8.00  -n 4 -b 2  > ./$SRC/tflus800n4b2.c
python openmpeigenbench_flush.py -f 9.00  -n 4 -b 2  > ./$SRC/tflus900n4b2.c
