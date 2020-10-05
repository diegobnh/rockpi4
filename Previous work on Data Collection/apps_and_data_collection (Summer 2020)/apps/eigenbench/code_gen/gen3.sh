# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
rm -r src3
mkdir src3
python openmpeigenbench_v3.py  -i 1024 -c 10 -a 0 -r NO -sd dynamic   > ./src3/ts10c10a0rnsd_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 0 -a 0 -r NO -sd dynamic   > ./src3/ts10c0a0rnsd_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 15 -a 0 -r NO -sd dynamic   > ./src3/ts10c15a0rnsd_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 20 -a 0 -r NO -sd dynamic   > ./src3/ts10c20a0rnsd_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 2 -a 0 -r NO -sd dynamic   > ./src3/ts10c2a0rnsd_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 4 -a 0 -r NO -sd dynamic   > ./src3/ts10c4a0rnsd_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 1 -a 0 -r NO -sd dynamic   > ./src3/ts10c1a0rnsd_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 0 -a 5 -r NO -sd dynamic   > ./src3/ts10c0a5rnsd_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 0 -a 3 -r NO -sd dynamic   > ./src3/ts10c0a3rnsd_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 0 -a 2 -r NO -sd dynamic   > ./src3/ts10c0a2rnsd_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 0 -a 1 -r NO -sd dynamic   > ./src3/ts10ca1rnsd_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 0 -a 10 -r NO -sd dynamic   > ./src3/ts10c0a10rnsd_v3.c


python openmpeigenbench_v3.py  -i 2048 -c 10 -a 0 -r NO -sd dynamic   > ./src3/ts11c10a0rnsd_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 0 -a 0 -r NO -sd dynamic   > ./src3/ts11c0a0rnsd_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 15 -a 0 -r NO -sd dynamic   > ./src3/ts11c15a0rnsd_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 20 -a 0 -r NO -sd dynamic   > ./src3/ts11c20a0rnsd_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 2 -a 0 -r NO -sd dynamic   > ./src3/ts11c2a0rnsd_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 4 -a 0 -r NO -sd dynamic   > ./src3/ts11c4a0rnsd_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 1 -a 0 -r NO -sd dynamic   > ./src3/ts11c1a0rnsd_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 0 -a 5 -r NO -sd dynamic   > ./src3/ts11c0a5rnsd_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 0 -a 3 -r NO -sd dynamic   > ./src3/ts11c0a3rnsd_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 0 -a 2 -r NO -sd dynamic   > ./src3/ts11c0a2rnsd_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 0 -a 1 -r NO -sd dynamic   > ./src3/ts11ca1rnsd_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 0 -a 10 -r NO -sd dynamic   > ./src3/ts11c0a10rnsd_v3.c


python openmpeigenbench_v3.py  -i 1024 -c 10 -a 0 -r NO -sd static   > ./src3/ts10c10a0rns_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 0 -a 0 -r NO -sd static   > ./src3/ts10c0a0rns_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 15 -a 0 -r NO -sd static   > ./src3/ts10c15a0rns_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 20 -a 0 -r NO -sd static   > ./src3/ts10c20a0rns_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 2 -a 0 -r NO -sd static   > ./src3/ts10c2a0rns_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 4 -a 0 -r NO -sd static   > ./src3/ts10c4a0rns_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 1 -a 0 -r NO -sd static   > ./src3/ts10c1a0rns_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 0 -a 5 -r NO -sd static   > ./src3/ts10c0a5rns_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 0 -a 3 -r NO -sd static   > ./src3/ts10c0a3rns_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 0 -a 2 -r NO -sd static   > ./src3/ts10c0a2rns_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 0 -a 1 -r NO -sd static   > ./src3/ts10ca1rns_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 0 -a 10 -r NO -sd static   > ./src3/ts10c0a10rns_v3.c


python openmpeigenbench_v3.py  -i 2048 -c 10 -a 0 -r NO -sd static   > ./src3/ts11c10a0rns_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 0 -a 0 -r NO -sd static   > ./src3/ts11c0a0rns_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 15 -a 0 -r NO -sd static   > ./src3/ts11c15a0rns_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 20 -a 0 -r NO -sd static   > ./src3/ts11c20a0rns_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 2 -a 0 -r NO -sd static   > ./src3/ts11c2a0rns_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 4 -a 0 -r NO -sd static   > ./src3/ts11c4a0rns_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 1 -a 0 -r NO -sd static   > ./src3/ts11c1a0rns_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 0 -a 5 -r NO -sd static   > ./src3/ts11c0a5rns_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 0 -a 3 -r NO -sd static   > ./src3/ts11c0a3rns_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 0 -a 2 -r NO -sd static   > ./src3/ts11c0a2rns_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 0 -a 1 -r NO -sd static   > ./src3/ts11ca1rns_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 0 -a 10 -r NO -sd static   > ./src3/ts11c0a10rns_v3.c


python openmpeigenbench_v3.py  -i 2048 -c 0 -a 0 -r YES -sd static   > ./src3/ts11c0a0rys_v3.c
python openmpeigenbench_v3.py  -i 2048 -c 0 -a 0 -r YES -sd dynamic   > ./src3/ts11c0a0rys_v3.c


python openmpeigenbench_v3.py  -i 1024 -c 0 -a 0 -r YES -sd static   > ./src3/ts10c0a0rysd_v3.c
python openmpeigenbench_v3.py  -i 1024 -c 0 -a 0 -r YES -sd dynamic   > ./src3/ts10c0a0rysd_v3.c



