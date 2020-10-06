#! /bin/bash
id_outliers()
{

        #Find IQR, Q1, and Q3 via datamash
        #Use counter to keep track of line number
        #For each entry in ExecutionTimes.txt
        #If entry < Q1 - 1.5*IQR or entry > Q3 + 1.5*IQR then entry is an outlier

        #cd ../../apps/$1/pmcs
        FOLDERS=`ls -d */`
        for i in $FOLDERS;
        do
                cd $i

                IQR=$(cat ExecutionTimes.txt | datamash iqr 1)
                Q1=$(cat ExecutionTimes.txt | datamash q1 1)
                Q3=$(cat ExecutionTimes.txt | datamash q3 1)

                HAS_OUTLIER=1
                let LINE=1

                LOWER=$(echo "scale=9; $( printf "%.9f" $Q1 ) - ( 1.5 * $(printf "%.9f" $IQR) )" | bc)
                UPPER=$(echo "scale=9; $( printf "%.9f" $Q3 ) + ( 1.5 * $(printf "%.9f" $IQR) )" | bc)

                OUTPUT="${i}"

                cat ExecutionTimes.txt | (while read ENTRY
                do
                        if (( $(echo "scale=9;$( printf "%.9f" $ENTRY ) < $LOWER" | bc -l) )) || (( $(echo "scale=9;$( printf "%.9f" $ENTRY ) > $UPPER" | bc -l) ))
                        then
                                OUTPUT+=" ${LINE}"
                                HAS_OUTLIER=0
                        fi
                        let LINE++
                done

                if [ "$HAS_OUTLIER" = "0" ]
                then
                        echo $OUTPUT
                fi)

                cd ..
        done
}
cd $APP_PMC_DIR
id_outliers > $APP_OUT_DIR/outliers.txt
