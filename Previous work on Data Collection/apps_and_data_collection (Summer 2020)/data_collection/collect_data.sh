#! /bin/bash

# $1 is the application
# $2 number of outlier recollection iterations

cd scripts

#Make export statements to clean up the .. notation
export APP_BIN_DIR=($PWD)"/../app/$1/bin"
export APP_PMC_DIR=($PWD)"/../app/$1/pmc"
export APP_OUT_DIR=($PWD)"/../app/$1/outlier_dir"

export COLLECTION_SCRIPTS_PATH=($PWD)"/scripts"
export COLLECTOR_PATH=($PWD)"/bin"

echo $APP_BIN_DIR
echo $APP_PMC_DIR
echo $APP_OUT_DIR
echo $COLLECTION_SCRIPTS_PATH
echo $COLLECTOR_PATH


sudo ./collect_initial.sh $1
sudo ./fix_outliers_loop.sh $1 $2
sudo ./recollect_bad_binaries.sh $1
sudo ./create_dataset.sh $1
