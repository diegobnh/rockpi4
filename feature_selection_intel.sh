#!/bin/bash

start=`date +%s`

avg_dataset=("dataset_median_dram.csv")
featSelec=("FilterCorrelation" "HCA_FilterCorrelation" "WrapperImportance")
seed=(2021 2023)
kfold=(5 10)

#rm -f *.png 
#rm -r -d */
for ((w=0; w<${#seed[@]}; w++)); do
    for((k=0; k<${#avg_dataset[@]}; k++)); do
	for ((j=0; j< ${#featSelec[@]}; j++)); do	   
	  for ((i=0; i< ${#kfold[@]}; i++)); do
               echo "Running "${featSelec[$j]} " kfold "${kfold[$i]}"  seed "${seed[$w]}  
               date=$(date +%T)
               mkdir -p ${featSelec[$j]}"_kfold_"${kfold[$i]}"_seed_"${seed[$w]}"_"$date
               rm -f ${featSelec[$j]}"_kfold_"${kfold[$i]}/*
	       python3 feature_selection_intel_apresentation_v3.py all-consolidate-post-process.csv ${avg_dataset[$k]} ${featSelec[$j]} ${seed[$w]} ${kfold[$i]} 
               sed -i '/No handles with labels found to put in legend./d' output
               sed -i '/The PostScript backend does not support transparency; partially transparent artists will be rendered opaque./d' output
               mv output *Accuracy.csv *Best_PMCs.csv ${featSelec[$j]}"_kfold_"${kfold[$i]}"_seed_"${seed[$w]}"_"$date
	  done	     
	done
    done
done

end=`date +%s`
runtime=$((end-start))
echo $runtime | awk '{printf "%.2f minutes\n", $1/60.0}' > ExecutionTime

#tar -cf Results.tar ExecutionTime HCA_* ; xz -z -T0  Results.tar 




