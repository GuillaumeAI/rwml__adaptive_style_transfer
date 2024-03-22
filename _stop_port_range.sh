#!/bin/bash
source _env.sh

# stop containers running in a port range
s=$1
e=$2

for p in $(seq $s $e)
do
	echo $p
	#./_adm__stopRemove_Containers__210502.sh --list --port | grep 71:|tr ":" " "| awk '// { print $2}'
	containercontext=$($admscript --list --port  | grep  "$p:" |tr ":" " "| awk '// { print $2}'||echo "0")
	if [ "$containercontext" == "0" ]; then
		echo "No container running on port $p"
		continue
	fi
	
	docker stop $containercontext &>/dev/null  &&echo "Container $containercontext stopped and NOT removed"

done

