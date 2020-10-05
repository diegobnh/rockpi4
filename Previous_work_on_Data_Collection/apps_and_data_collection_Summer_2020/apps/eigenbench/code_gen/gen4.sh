# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
rm -r src4
mkdir src4
python openmpeigenbench_v4.py -f YES  -m 0.4  -sd static > ./src4/tfym4s_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.45  -sd static > ./src4/tfym45s_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.5  -sd static > ./src4/tfym5s_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.55  -sd static > ./src4/tfym55s_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.6  -sd static > ./src4/tfym6s_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.65  -sd static > ./src4/tfym65s_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.7  -sd static > ./src4/tfym7s_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.75  -sd static > ./src4/tfym75s_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.8  -sd static > ./src4/tfym8s_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.85  -sd static > ./src4/tfym85s_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.9  -sd static > ./src4/tfym9s_v4.c

python openmpeigenbench_v4.py -f NO  -m 0.4  -sd static > ./src4/tfnm4s_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.45  -sd static > ./src4/tfnm45s_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.5  -sd static > ./src4/tfnm5s_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.55  -sd static > ./src4/tfnm55s_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.6  -sd static > ./src4/tfnm6s_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.65  -sd static > ./src4/tfnm65s_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.7  -sd static > ./src4/tfnm7s_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.75  -sd static > ./src4/tfnm75s_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.8  -sd static > ./src4/tfnm8s_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.85  -sd static > ./src4/tfnm85s_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.9  -sd static > ./src4/tfnm9s_v4.c


python openmpeigenbench_v4.py -f YES  -m 0.4  -sd dynamic > ./src4/tfym4sd_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.45  -sd dynamic > ./src4/tfym45sd_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.5  -sd dynamic > ./src4/tfym5sd_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.55  -sd dynamic > ./src4/tfym55sd_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.6  -sd dynamic > ./src4/tfym6sd_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.65  -sd dynamic > ./src4/tfym65sd_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.7  -sd dynamic > ./src4/tfym7sd_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.75  -sd dynamic > ./src4/tfym75sd_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.8  -sd dynamic > ./src4/tfym8sd_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.85  -sd dynamic > ./src4/tfym85sd_v4.c
python openmpeigenbench_v4.py -f YES  -m 0.9  -sd dynamic > ./src4/tfym9sd_v4.c


python openmpeigenbench_v4.py -f NO  -m 0.4  -sd dynamic > ./src4/tfnm4sd_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.45  -sd dynamic > ./src4/tfnm45sd_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.5  -sd dynamic > ./src4/tfnm5sd_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.55  -sd dynamic > ./src4/tfnm55sd_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.6  -sd dynamic > ./src4/tfnm6sd_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.65  -sd dynamic > ./src4/tfnm65sd_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.7  -sd dynamic > ./src4/tfnm7sd_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.75  -sd dynamic > ./src4/tfnm75sd_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.8  -sd dynamic > ./src4/tfnm8sd_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.85  -sd dynamic > ./src4/tfnm85sd_v4.c
python openmpeigenbench_v4.py -f NO  -m 0.9  -sd dynamic > ./src4/tfnm9sd_v4.c


