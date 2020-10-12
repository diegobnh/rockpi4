#!/bin/bash

remove_excedent_lines_and_aggregate()
{
    FOLDERS=`ls -d */`

    for i in $FOLDERS ;
    do
            cd $i
            
            #backup of files because we will remove some lines
            files=$(ls *.csv)
            for f in $files ;
            do
		cp $f $f.bkp
            done
          
            #remove first line because the values is not representative
            #sed -i '1d' *.csv
                       
            files=`ls *.csv`
            for f in $files; do
                cut -d, -f1 --complement $f > temp                   #remove the first column time
                mv temp $f              
            done
                       
            #get the minimum number of lines from all csv files and remove the excedent lines
            NUM_LINHAS_COMUM_PMCS=$(wc -l *.csv | awk '{print $1}' | sed '$d' | datamash min 1)
	    sed -i -n "1,$NUM_LINHAS_COMUM_PMCS p" *.csv
                       
            paste *.csv -d, > consolidated-pmc.dat
            num_columns=$(cat consolidated-pmc.dat | awk -F, 'NR==1 {print NF; exit;}')

            #cat consolidated-pmc.dat | tr "," "\t" | datamash mean 1-$num_columns median 1-$num_columns q1 1-$num_columns q3 1-$num_columns mode 1-$num_columns sstdev 1-$num_columns | awk '{for (i=1; i<=NF; i++) { if(i == NF){ printf "%.2f\n", $i} else{ printf "%.2f\t", $i;} } }' | tr "," "." | tr "\t" "," > consolidated-pmc.statistic
          
            #undo - recovery original files
            files=$(ls *.bkp)
            for f in $files ;
            do
                filename=$(echo "$f" | cut -f 1 -d '.')
		mv $f $filename.csv
            done

            cd ..
    done

}


calculate_time_DRAM()
{
    FOLDERS=`ls -d */`
    for i in $FOLDERS ;
    do
         cd $i
         cat ExecutionTimes.txt | datamash median 1 > ExecutionTimes.median
         cd ..
    done

}

calculate_time_PMEM()
{
    FOLDERS=`ls -d */`
    for i in $FOLDERS ;
    do
         cd $i
         cat Execu* | datamash median 1 > ExecutionTimes.median
         cd ..
    done

}


create_dataset_DRAM()
{
    cat */ExecutionTimes.median > DRAM_execution_times   
    #cat */consolidated-pmc.statistic | awk -F "," '{print}' > DRAM_statistic_dataset.csv
    cat */consolidated-pmc.dat | awk -F "," '{print}' > DRAM_dataset.csv

    folders=$(ls -d */)
    for f in $folders; do
         cd $f
                files=$(ls *.csv)
                for file in $files; do
                     unique_pmcs=$(echo $file | cut -f 1 -d '.' | tr "\n" "," | tr "_" ",")
                     column_names="cycles,instructions,"$unique_pmcs"cpu_power,dram_power,pkg_power"
                     echo $column_names >> $BENCHMARK_PATH/dataset/column_names
                done
                cd $BENCHMARK_PATH/dataset/
                cat column_names | tr '\n' ',' > temp
                mv temp column_names
         	break         
    done

    cd $BENCHMARK_PATH/pmcs
    mv *.csv *_execution_times $BENCHMARK_PATH/dataset
}



create_dataset_PMEM()
{
    FOLDERS=`ls -d */`
    for i in $FOLDERS ;
    do
         cd $i

            files=$(ls *.csv)
            for f in $files ;
            do
		cp $f $f.bkp
            done

            files=`ls *.csv`
            for f in $files; do
                cut -d, -f1 --complement $f > temp
                mv temp $f
            done
            

            num_columns=$(cat *.csv | awk -F, 'NR==1 {print NF; exit;}')  #we have just one file csv
            cat *.csv | tr "," "\t" | datamash mean 1-$num_columns median 1-$num_columns q1 1-$num_columns q3 1-$num_columns mode 1-$num_columns sstdev 1-$num_columns | awk '{for (i=1; i<=NF; i++) { if(i == NF){ printf "%.2f\n", $i} else{ printf "%.2f\t", $i;} } }' | tr "," "." | tr "\t" "," > consolidated-pmc.statistic

            #undo - recovery original files
            files=$(ls *.bkp)
            for f in $files ;
            do
                filename=$(echo "$f" | cut -f 1 -d '.')
		mv $f $filename.csv
            done


         cd ..
    done

    cat */ExecutionTimes.median > PMEM_execution_times   
    cat */consolidated-pmc.statistic | awk -F "," '{print}' > PMEM_statistic_dataset.csv
    cat */*.csv | awk -F "," '{print}' > PMEM_dataset.csv
    
    cd $BENCHMARK_PATH/pmcs
    mv *.csv *_execution_times $BENCHMARK_PATH/dataset
}

cd $BENCHMARK_PATH/pmcs

if [ $FLAG_DRAM == 'True' ]; then 
    remove_excedent_lines_and_aggregate
    #read -p "All the dataset was aggregated..press ENTER to continue"
    calculate_time_DRAM
    #read -p "All the execution time was calculated..press ENTER to continue"
    create_dataset_DRAM
    #read -p "Dataset was created..press ENTER to finish!"
fi

if [ $FLAG_PMEM == 'True' ]; then     
    calculate_time_PMEM    
    create_dataset_PMEM    
fi


