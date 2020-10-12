#! /bin/bash

cp ExecutionTimes.txt.bkp ExecutionTimes.txt

'''
while-loop is executed in a subshell, so changes to the variable inside the while-loop wont affect the external variable.
'''

old_times=()
while read entry;
do
	old_times+=( $entry )
done < ExecutionTimes.txt

echo "ORIGINAL EXECUTION TIME"
for entry in "${old_times[@]}" #agora percorre a variável 
do
     echo $entry
done


lines_to_recollect=()
#cat outliers.txt | 
while read LINE;
do 
	parsed_outlier=()
	for entry in $(echo $LINE | tr " " "\n")  # você separa a linha em várias
	do
       		parsed_outlier+=( $entry )
	done

	folders=${parsed_outlier[0]}  #pega a primeira parte que se refere ao nome da aplicação

	for entry in "${parsed_outlier[@]}" #agora percorre a variável 
	do                
        	if [ "$entry" != "$folders" ]
        	then
                	lines_to_recollect+=( $entry )  #get line number of outliers
        	fi
	done
done < outliers.txt
echo "LINES TO RECOLLECT"
for entry in "${lines_to_recollect[@]}" #agora percorre a variável 
do
     echo $entry
done

#SIMULA UMA NOVA EXECUÇÃO
cp ExecutionTimes2.txt ExecutionTimes.txt 

#Now merge old time with new specific time for outliers
new_times=() 
while read entry
do
	new_times+=( $entry )
done < ExecutionTimes.txt

echo "NEW TIMES"
for entry in "${new_times[@]}" #agora percorre a variável 
do
     echo $entry
done

count=0
for i in "${lines_to_recollect[@]}"
do
	#for j in "${new_times[@]}"
	#do
		let "index=$i-1"
		#old_times[$index]=$j
                old_times[$index]=${new_times[$count]}
                let "count=$count+1"
	#done
done
echo "AFTER UPDATE"
for entry in "${old_times[@]}" #agora percorre a variável 
do
     echo $entry
done

rm ExecutionTimes.txt

output=""
for i in "${old_times[@]}"
do
	output+="$i${NL}" 
done

printf "$output" > ExecutionTimesUpdated.txt




