#! /bin/bash

export NUM_ITERATIONS_FOR_OUTLIER=100
export COLLECTOR_PATH="/home/dbmm/pmcs_collection/intel_optane_collector_pmcs/bin"
export DATA_COLLECTION_PATH=$(pwd)

FLAG_DRAM="True"
FLAG_PMEM="False"

if [ $FLAG_DRAM == 'True' ]; then
	echo "************************"
        echo "Starting DRAM collection" 
	echo "************************"
	export BENCHMARK_PATH="/home/dbmm/DRAM_bc_streets"
	export PMCS_FILE="/home/dbmm/pmcs_collection/intel_optane_collector_pmcs/DRAM_pmcs.txt"

	mkdir -p $BENCHMARK_PATH/bin ;      rm -f -r $BENCHMARK_PATH/bin/* ;
	mkdir -p $BENCHMARK_PATH/dataset ;  rm -f -r $BENCHMARK_PATH/dataset/* ;
	mkdir -p $BENCHMARK_PATH/outlier;   rm -f -r $BENCHMARK_PATH/outlier/*;
	mkdir -p $BENCHMARK_PATH/pmcs;      
        #read -p "Are you have sure that you want to delete pmc folder ?" ; 
        rm -f -r $BENCHMARK_PATH/pmcs/*; 

	cd scripts

	source ./1_Adapt_app_to_script_format.sh                  ; printf "Step 1 - Finished \n-------------------\n";
	source ./2_Start_collect.sh                               ; printf "Step 2 - Finished \n-------------------\n";
	source ./3_Management_outliers.sh                         ; printf "Step 3 - Finished \n-------------------\n";
	source ./4_Check_if_exist_any_problem.sh > $BENCHMARK_PATH/problems.txt   ; printf "Step 4 - Finished (Check problems.txt file!) \n-------------------\n"; 
	source ./5_Create_dataset.sh                              ; printf "Step 5 - Finished \n-------------------\n";
        
        cd $DATA_COLLECTION_PATH
fi 

FLAG_DRAM="False"
FLAG_PMEM="True"

if [ $FLAG_PMEM == 'True' ]; then
	echo "************************"
        echo "Starting PMEM collection" 
	echo "************************"

	export BENCHMARK_PATH="/home/dbmm/PMEM_bc_streets"
	export PMCS_FILE="/home/dbmm/pmcs_collection/intel_optane_collector_pmcs/PMEM_pmcs.txt" #It not necessary collect all pmcs, just one of them!

	mkdir -p $BENCHMARK_PATH/bin ;      rm -f -r $BENCHMARK_PATH/bin/* ;
	mkdir -p $BENCHMARK_PATH/dataset ;  rm -f -r $BENCHMARK_PATH/dataset/* ;	
	mkdir -p $BENCHMARK_PATH/pmcs;      rm -f -r $BENCHMARK_PATH/pmcs/*; 

	cd scripts

	source ./1_Adapt_app_to_script_format_remote.sh           ; printf "Step 1 - Finished \n-------------------\n";
	source ./2_Start_collect.sh                               ; printf "Step 2 - Finished \n-------------------\n";
	source ./5_Create_dataset.sh   
        cd $DATA_COLLECTION_PATH
fi 

