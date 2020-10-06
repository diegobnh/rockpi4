#! /bin/bash

# $1 is the application
# $2 number of outlier recollection iterations



#Make export statements to clean up the .. notation
export APP_BIN_DIR=$PWD"/../apps/$1/bin"
export APP_PMC_DIR=$PWD"/../apps/$1/pmcs"
export APP_OUT_DIR=$PWD"/../apps/$1/outlier_dir"
export APP_DAT_DIR=$PWD"/../apps/$1/datasets"
export APP_GOUT_DIR=$PWD"/../apps/$1/good_outlier_dir"

export COLLECTION_SCRIPTS_PATH=$PWD"/scripts"
export COLLECTOR_PATH=$PWD"/bin"

cd $COLLECTION_SCRIPTS_PATH
(source collect_initial.sh $1)
(source fix_outliers_loop.sh $1 $2)
(source recollect_bad_binaries.sh $1)
(source create_dataset.sh $1)
