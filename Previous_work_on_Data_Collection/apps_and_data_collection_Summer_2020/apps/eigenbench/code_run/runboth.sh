# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
./gencritical.sh
./genompfor.sh
./compilecritical.sh
./compilefor.sh
./runeigen.sh ./runcritical.sh readingscritical ./runcriticalwithoutlittlealone.sh
./runeigen.sh ./runfor.sh readingsfor ./runforwithoutlittlealone.sh
