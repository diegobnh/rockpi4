#!/bin/bash

read -p 'Is your first time running on this dataset? Answer 1 for YES or 0 for NO: ' answer

check_stdev_pmcs()
{
    min=0.85
    FOLDERS=`ls -d */`
    for i in $FOLDERS ;
    do
       cd $i
       value=$(cat ExecutionTimes.txt | datamash min 1 max 1 | awk '{printf "%.2f\n", ($1/$2)}')

       if [ 1 -eq `echo "${value} < ${min}" | bc` ]
       then
          echo $i
          echo -n "diff:"
          echo -n "1 $value" | awk '{print $1-$2"%"}'
          cat ExecutionTimes.txt | datamash min 1 max 1
          echo "------------------------"
       fi;
       cd ..
    done
}


remove_excedent_lines_and_aggregate()
{
    FOLDERS=`ls -d */`
    for i in $FOLDERS ;
    do
            cd $i
            echo "Manipulating "$i
            #if [ $answer -eq 1 ]; then
              #echo "Removing some lines from your dataset"
              #sed -i '1,2d;$d' *.csv
            #fi

            #Need minimum between A53 and A72 Directories, not just one or the other
	    NUM_LINHAS_COMUM_PMCS=$(wc -l *.csv | awk '{print $1}' | sed '$d' | datamash min 1)

            ######################## Caleb's Code ##################################
            parse=()
            for entry in $(echo $i | tr "_" "\n")
            do
              parse+=( $entry )
            done

            #initialize variables
            bin_dir=${parse[0]}
            bin_file=${parse[1]}

            #We only need to handle the A53 directories with conditional logic
            #    since these directories will always come first in the
            #    ls -d */ command, and we can then handle the complementary
            #    A72 directory
            if [[ $i == 4l2b_A53* ]]
            then
              bin_dir=${parse[2]}
              bin_file=$bin_dir"_"${parse[3]}
              cd ../4l2b_A72_${bin_file}_pmcs
              a72_min_lines=$(wc -l *.csv | awk '{print $1}' | sed '$d' | datamash min 1)
              cd ../$i

              #Found minimum between A53 and A72 directories
              if [[ NUM_LINHAS_COMUM_PMCS -gt a72_min_lines ]]; then
                NUM_LINHAS_COMUM_PMCS=$a72_min_lines
              fi

            fi

            ##########################################################################


            #minimum number of lines is always stored in NUM_LINHAS_COMUM_PMCS variable
            #remove all lines after the minimum
	    #sed -i -n "1,$NUM_LINHAS_COMUM_PMCS p" *.csv


            ############################ Caleb #######################################
            #Remove lines and remove column times from A72 directory's files

	    #paste *.csv -d , > debug.dat

            if [[ $i == 4l2b_A53* ]]
            then
              echo "Handling A72 Directory..."

              cd ../4l2b_A72_${bin_file}_pmcs

              sed -i -n "1,$NUM_LINHAS_COMUM_PMCS p" *.csv

	      #put check here: removing time stamps
	      if [ $answer -eq 1 ]; then
              	 files=`ls *.csv`
              	 for f in $files; do
                    	cut -d, -f1 --complement $f > temp
                   	mv temp $f
             	 done
	      fi

              cd ../$i

            fi


            if [[ $i != 4l2b_A72* ]]
            then

              sed -i -n "1,$NUM_LINHAS_COMUM_PMCS p" *.csv
	      #put check here: removing time stamps
	      if [ $answer -eq 1 ]; then
              	files=`ls *.csv`
              	for f in $files; do
                    cut -d, -f1 --complement $f > temp
                    mv temp $f
              	done
	      fi
            fi
            ##########################################################################


            #remove the column time
            #files=`ls *.csv`
            #for f in $files; do
            #      cut -d, -f1 --complement $f > temp
            #      mv temp $f
            #done

            #aggregate files
	    if [[ $i == 4l_* ]];
	    then
		     paste *.csv -d, > consolidated-pmc-little.dat
                     num_columns=$(cat consolidated-pmc-little.dat | awk -F, 'NR==1 {print NF; exit;}')
                     cat consolidated-pmc-little.dat | tr "," "\t" | datamash median 1-$num_columns | tr "," "." | tr "\t" "," > consolidated-pmc-little.avg

	    elif [[ $i == 2b_* ]];
	    then
		     paste *.csv -d, > consolidated-pmc-big.dat
                     num_columns=$(cat consolidated-pmc-big.dat | awk -F, 'NR==1 {print NF; exit;}')
                     cat consolidated-pmc-big.dat | tr "," "\t" | datamash median 1-$num_columns | tr "," "." | tr "\t" "," > consolidated-pmc-big.avg
            ############################## Caleb ##############################
            elif [[ $i == 4l2b_A53_* ]]
            then
                      paste *.csv -d, > consolidated-pmc-little.dat
                      num_columns=$(cat consolidated-pmc-little.dat | awk -F, 'NR==1 {print NF; exit;}')
                      cat consolidated-pmc-little.dat | tr "," "\t" | datamash median 1-$num_columns | tr "," "." | tr "\t" "," > consolidated-pmc-little.avg

                      #Do the same in the A72 directory
                      cd ../4l2b_A72_${bin_file}_pmcs

                      paste *.csv -d, > consolidated-pmc-big.dat
                      num_columns=$(cat consolidated-pmc-big.dat | awk -F, 'NR==1 {print NF; exit;}')
                      cat consolidated-pmc-big.dat | tr "," "\t" | datamash median 1-$num_columns | tr "," "." | tr "\t" "," > consolidated-pmc-big.avg

                      cd ../$i
	    fi
            ###################################################################

            cd ..
    done

}


calculate_time()
{
    FOLDERS=`ls -d */`
    for i in $FOLDERS ;
    do
         cd $i
         cat ExecutionTimes.txt | datamash median 1 > ExecutionTimes.avg
         cd ..
    done

}

create_dataset()
{
    #calculate the execution time
    cat 4l_*/ExecutionTimes.avg > 4l_times
    cat 2b_*/ExecutionTimes.avg >2b_times
    cat 4l2b_A53_*/ExecutionTimes.avg > 4l2b_a53_times
    cat 4l2b_A72_*/ExecutionTimes.avg > 4l2b_a72_times
    paste 4l2b_a53_times 4l2b_a72_times | awk '{print ($1+$2)*0.50}' > 4l2b_times

    paste 4l2b_times 2b_times 4l_times | awk '{OFS=","} {printf "%.6f,%.6f\n", $3/$2, $3/$1}' > 4l_predict_performance
    paste 4l2b_times 2b_times 4l_times | awk '{OFS=","} {printf "%.6f,%.6f\n", $2/$3, $2/$1}' > 2b_predict_performance
    paste 4l2b_times 2b_times 4l_times | awk '{OFS=","} {printf "%.6f,%.6f\n", $1/$3, $1/$2}' > 4l2b_predict_performance

    #################Caleb###############
    #paste 4l2b_times 4l2b_a72_times 4l2b_a53_times | awk '{OFS=","} {printf "%.6f,%.6f\n", $1/$3, $1/$2}' > 4l2b_predict_performance
    #####################################

    rm *_times

    #create dataset for 4l
    cat 4l_*/consolidated-pmc-little.avg | awk -F "," '{print}' > 4l_median_dataset.csv
    paste 4l_median_dataset.csv 4l_predict_performance -d , > temp; mv temp 4l_median_dataset.csv
    cat 4l_*/consolidated-pmc-little.dat | awk -F "," '{print}' > 4l_dataset.csv

    #create dataset for 2b
    cat 2b_*/consolidated-pmc-big.avg | awk -F "," '{print}' > 2b_median_dataset.csv
    paste 2b_median_dataset.csv 2b_predict_performance -d , > temp; mv temp 2b_median_dataset.csv
    cat 2b_*/consolidated-pmc-big.dat | awk -F "," '{print}' > 2b_dataset.csv

    ############################# Caleb ########################################
    #create dataset for 4l2b
    cat 4l2b_A53*/consolidated-pmc-little.avg | awk -F "," '{print}' > 4l2b_a53_median_dataset.csv
    cat 4l2b_A72*/consolidated-pmc-big.avg | awk -F "," '{print}' > 4l2b_a72_median_dataset.csv
    echo "number of columns for a53_median "$(cat 4l2b_a53_median_dataset.csv | awk -F, "{print NF}" | datamash min 1 max 1)
    echo "number of columns for a72_median "$(cat 4l2b_a72_median_dataset.csv | awk -F, "{print NF}" | datamash min 1 max 1)
    echo "number of columns for 4l2b_predict_performance "$(cat 4l2b_predict_performance | awk -F, "{print NF}" | datamash min 1 max 1)
    echo "----------------------------"
    paste 4l2b_a53_median_dataset.csv 4l2b_a72_median_dataset.csv -d , > temp.csv
    paste temp.csv 4l2b_predict_performance -d , > 4l2b_median_dataset.csv

    cat 4l2b_A53*/consolidated-pmc-little.dat > unlabeled_a53.txt
    cat 4l2b_A72*/consolidated-pmc-big.dat > unlabeled_a72.txt
    paste unlabeled_a53.txt unlabeled_a72.txt -d , > unlabeled_combo.txt
    cat unlabeled_combo.txt | awk -F "," '{print}' > 4l2b_dataset.csv

    sudo rm unlabeled*
    sudo rm 4l2b_a53_median_dataset.csv
    sudo rm 4l2b_a72_median_dataset.csv
    sudo rm temp.csv
    ############################################################################
}

cd ../../apps/$1/pmcs

check_stdev_pmcs
read -p "Check the standard deviation time..press ENTER to continue"
remove_excedent_lines_and_aggregate
read -p "All the dataset was aggregated..press ENTER to continue"
calculate_time
read -p "All the execution time was calculated..press ENTER to continue"
create_dataset
read -p "Partial Dataset was created..press ENTER to finish!"

mv *.csv ../datasets
