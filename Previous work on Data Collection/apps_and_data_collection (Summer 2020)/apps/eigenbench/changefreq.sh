# Copyright (c) 2018 Jyothi Krishna V.S., Rupesh Nasre, Shankar Balachandran, IIT Madras.
# This file is a part of the project CES, licensed under the MIT license.
# See LICENSE.md for the full text of the license.
# 
# The above notice shall be included in all copies or substantial 
# portions of this file.
echo $1 > /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
echo "New Frequency is " 
cat /sys/devices/system/cpu/cpu4/cpufreq/scaling_max_freq
