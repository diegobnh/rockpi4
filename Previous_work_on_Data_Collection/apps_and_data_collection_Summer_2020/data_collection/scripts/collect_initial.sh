#! /bin/bash

#Script to collect all PMCs for all microbenchmarks
#The mircobenchmarks from the EPCC OpenMP Microbenchmark Suite Version 3.1
#and the Eigenbench Microbenchmarks used in the CHOAMP paper

#Cluster configurations: 0-3, 4-5, and 0-5 (4 little, 2 big, and 4 little with 2 big)

#General command: taskset -a -c <cluster config> ./bin/scheduler ./microbenchmark -arg1 -arg2 ...

# $1 is the application name
# $2 is the core type

for ((i=0 ; i< $(nproc); i++));
do
  echo performance > /sys/devices/system/cpu/cpu$i/cpufreq/scaling_governor;
done

#cd /home/rock/apps_and_data_collection/data_collection/scripts
cd "$APP_BIN_DIR"

for file in ./*
do
  #This is annoying. Is there a better way to do this?
  ls
  echo $file
  filename="${file##*/}"
  temp=`echo -n $filename | tail -c 4`
  temp2="${temp#*n}"
  temp3="${temp2#*b}"
  temp4="${temp3%s*}"

  threads="${temp2%b*}"
  big="${temp4%s*}"

  NL=$'\n'

  #Now to run Diego's schedulers with some logic.

  #2 big configuration
  if [[ "$threads" == "2" ]]; then

    output="11${NL}"
    output+="1 0x01,0x02,0x03,0x04,0x05,0x08${NL}"
    output+="2 0x09,0x10,0x11,0x12,0x13,0x14${NL}"
    output+="3 0x15,0x16,0x17,0x18,0x19,0x1B${NL}"
    output+="4 0x1D,0x40,0x41,0x42,0x43,0x46${NL}"
    output+="5 0x47,0x48,0x4C,0x4D,0x50,0x51${NL}"
    output+="6 0x52,0x53,0x56,0x58,0x60,0x61${NL}"
    output+="7 0x62,0x64,0x66,0x67,0x68,0x69${NL}"
    output+="8 0x6A,0x6C,0x6D,0x6E,0x70,0x71${NL}"
    output+="9 0x72,0x73,0x74,0x75,0x76,0x78${NL}"
    output+="10 0x79,0x7A,0x7C,0x7E,0x81,0x82${NL}"
    output+="11 0x83,0x84,0x86,0x90,0x91,0x00${NL}"


    printf "$output" > pmcs_schedule.txt

    sudo taskset -a -c 4-5 $COLLECTOR_PATH/scheduler_A72 ./$filename
    sudo rm -r "$APP_PMC_DIR""/2b_${filename}_pmcs"
    mkdir "$APP_PMC_DIR""/2b_${filename}_pmcs"
    mv *.csv "$APP_PMC_DIR""/2b_${filename}_pmcs"
    mv *.txt "$APP_PMC_DIR""/2b_${filename}_pmcs"

  #4 little configuration
  elif [[ "$big" == "0" ]] && [[ "$threads" == "4"  ]]; then

    output="5${NL}"
    output+="1 0x01,0x02,0x03,0x04,0x05,0x06${NL}"
    output+="2 0x07,0x08,0x0A,0x0C,0x0D,0x0F${NL}"
    output+="3 0x10,0x11,0x12,0x13,0x14,0x15${NL}"
    output+="4 0x16,0x17,0x18,0x19,0x1D,0x60${NL}"
    output+="5 0x61,0x7A,0x86,0x00,0x00,0x00${NL}"

    printf "$output" > pmcs_schedule.txt

    sudo taskset -a -c 0-3 $COLLECTOR_PATH/scheduler_A53  ./$filename
    sudo rm -r "$APP_PMC_DIR""/4l_${filename}_pmcs"
    mkdir "$APP_PMC_DIR""/4l_${filename}_pmcs"
    mv *.csv "$APP_PMC_DIR""/4l_${filename}_pmcs"
    mv *.txt "$APP_PMC_DIR""/4l_${filename}_pmcs"

  #4 little and 2 big configuration
  elif [[ "$threads" == "6" ]]; then

    output="11${NL}"
    output+="1 0x01,0x02,0x03,0x04,0x05,0x08${NL}"
    output+="2 0x09,0x10,0x11,0x12,0x13,0x14${NL}"
    output+="3 0x15,0x16,0x17,0x18,0x19,0x1B${NL}"
    output+="4 0x1D,0x40,0x41,0x42,0x43,0x46${NL}"
    output+="5 0x47,0x48,0x4C,0x4D,0x50,0x51${NL}"
    output+="6 0x52,0x53,0x56,0x58,0x60,0x61${NL}"
    output+="7 0x62,0x64,0x66,0x67,0x68,0x69${NL}"
    output+="8 0x6A,0x6C,0x6D,0x6E,0x70,0x71${NL}"
    output+="9 0x72,0x73,0x74,0x75,0x76,0x78${NL}"
    output+="10 0x79,0x7A,0x7C,0x7E,0x81,0x82${NL}"
    output+="11 0x83,0x84,0x86,0x90,0x91,0x00${NL}"


    printf "$output" > pmcs_schedule.txt

    sudo taskset -a -c 0-5 $COLLECTOR_PATH/scheduler_A72  ./$filename
    sudo rm -r "$APP_PMC_DIR""/4l2b_A72_${filename}_pmcs"
    mkdir "$APP_PMC_DIR""/4l2b_A72_${filename}_pmcs"
    mv *.csv "$APP_PMC_DIR""/4l2b_A72_${filename}_pmcs"
    mv *.txt "$APP_PMC_DIR""/4l2b_A72_${filename}_pmcs"



    output="5${NL}"
    output+="1 0x01,0x02,0x03,0x04,0x05,0x06${NL}"
    output+="2 0x07,0x08,0x0A,0x0C,0x0D,0x0F${NL}"
    output+="3 0x10,0x11,0x12,0x13,0x14,0x15${NL}"
    output+="4 0x16,0x17,0x18,0x19,0x1D,0x60${NL}"
    output+="5 0x61,0x7A,0x86,0x00,0x00,0x00${NL}"

    printf "$output" > pmcs_schedule.txt

    sudo taskset -a -c 0-5 $COLLECTOR_PATH/scheduler_A53  ./$filename
    sudo rm -r "$APP_PMC_DIR""/4l2b_A53_${filename}_pmcs"
    mkdir "$APP_PMC_DIR""/4l2b_A53_${filename}_pmcs"
    mv *.csv "$APP_PMC_DIR""/4l2b_A53_${filename}_pmcs"
    mv *.txt "$APP_PMC_DIR""/4l2b_A53_${filename}_pmcs"

  else
    echo $threads
    echo $big
    echo Error: Is not a testable configuration!
  fi
  echo Waiting...
  sleep 10
done
