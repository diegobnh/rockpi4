# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
python openmpeigenbenchwithoutloop.py -c 1 -m 1 > ./src/tc1m1.c
python openmpeigenbenchwithoutloop.py -c 1 -m 0.75 > ./src/tc1m75.c
python openmpeigenbenchwithoutloop.py -c 1 -m 0.5 > ./src/tc1m5.c
python openmpeigenbenchwithoutloop.py -c 0.75 -m 1 > ./src/tc75m1.c
python openmpeigenbenchwithoutloop.py -c 0.75 -m 0.75 > ./src/tc75m75.c
python openmpeigenbenchwithoutloop.py -c 0.75 -m 0.5 > ./src/tc75m5.c
python openmpeigenbenchwithoutloop.py -c 0.5 -m 1 > ./src/tc5m1.c
python openmpeigenbenchwithoutloop.py -c 0.5 -m 0.75 > ./src/tc5m75.c
python openmpeigenbenchwithoutloop.py -c 0.5 -m 0.5 > ./src/tc5m5.c

