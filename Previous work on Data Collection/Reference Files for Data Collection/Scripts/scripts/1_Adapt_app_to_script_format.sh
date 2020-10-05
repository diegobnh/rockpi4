#! /bin/bash

BINARY_PATH="hwloc-bind --cpubind node=0 --membind node=0 /home/dbmm/Downloads/gapbs/"

APP_COMMANDS=("./bc -f /home/dbmm/Downloads/real_datasets_graph_format/Street_Networks/belgium.osm.graph.sg > /dev/null")

APP_NAMES=("bc_street_belgium")

for((k = 0; k< ${#APP_COMMANDS[@]}; k++));
do
	output=$'#! /bin/bash\n'
	output+="$BINARY_PATH${APP_COMMANDS[$k]}"

	filename=${APP_NAMES[$k]}
	echo "$output" > $filename".sh"

        chmod 777 $filename".sh"
	mv $filename".sh" $BENCHMARK_PATH/bin
done

