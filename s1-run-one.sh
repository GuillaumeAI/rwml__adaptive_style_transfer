#!/bin/bash
#
echo "Single One start 1"

export dispusage="0"

if [ "$1" == "" ] ||  [ "$2" == "" ] || [ "$3" == "" ] ; then
	export dispusage="1"
	
fi

if [ "$1" == "" ] && [ "$m" != "" ] ; then
	export dispusage="0"

fi

if [ "$dispusage" == "1" ] ||  [ "$ps" == "" ] || [ "$ck" == "" ] ; then
	if  [ "$m" != "" ] && [ "$ps" == "" ] || [ "$ck" == "" ]  ; then 
        	echo "or define:    m=<model>  ; ps=<fullStartPort>; ck=\"<105 120>\""
	else 
		echo "Usage: $0 <modelname> <fullStartPort> \"<checkpoint1 2 3...>\""
	fi 
	echo "you can also set: statusafterlaunch to stop "

else
	#

	s=./singleone-multi-cherkpoint-svc-mounter.sh
 	if [ "$2" != "" ]  ; then  	ps=$2 ;fi
	
	x1=600
#	x2=2000
	if [ "$1" != "" ]  ; then	m=$1 ; fi
	if [ "$3" != "" ]  ; then       ck="$3" ; fi
	
	#$s $m $ps $x1 $x2 "$(mckinfo $m)"
	$s $m $ps $x1 "$ck"

fi
