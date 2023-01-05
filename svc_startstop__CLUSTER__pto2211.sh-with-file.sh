#!/bin/bash

#default
desiredstate=stop

if [ -f "$1" ]; then
dsfn=$1
if [ "$2" == "start" ]; then desiredstate=start;fi
if [ "$2" == "--start" ]; then desiredstate=start;fi
if [ "$2" == "--run" ]; then desiredstate=start;fi
if [ "$2" == "--rm" ]; then desiredstate=rm;fi
if [ "$2" == "rm" ]; then desiredstate=rm;fi

. __rwfn.sh


for c in $(cat $dsfn);do
       	echo -n "$c "
	docker $desiredstate $c &> /dev/null && \
		echo "now in state $desiredstate " || \
		echo "State $desiredstate not achieved"
done


else # source file non existent
	echo "Require source file"
	echo "   $0 mysource.txt stop|start|rm"
fi
