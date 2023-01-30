#!/bin/bash
source _env.sh

# stop containers running in a port range
s=$1
e=$2

for p in $(seq $s $e)
do
	#./_adm__stopRemove_Containers__210502.sh --list --port | grep 71:|tr ":" " "| awk '// { print $2}'
	containercontext=$($admscript --list --port  | grep  "$p:" |tr ":" " "| awk '// { print $2}')
	docker stop $containercontext  && docker rm $containercontext

done

