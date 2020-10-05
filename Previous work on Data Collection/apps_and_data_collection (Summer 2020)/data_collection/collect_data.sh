#! /bin/bash

# $1 is the application
# $2 number of outlier recollection iterations

cd scripts

sudo ./collect_initial.sh $1
sudo ./fix_outliers_loop.sh $1 $2
sudo ./recollect_bad_binaries.sh $1
sudo ./create_dataset.sh $1
