#!/bin/bash

# Dev to mount specific checkpoint and launch an API Web service serving those checkpoints.
source $binroot/__fn.sh

# script.sh MODEL_NAME APIPORT IMGSIZE1 IMGSIZE2 CHECKPOINT_NUM [--fg(debug)] 

source _env.sh
source .env

showhelp=0
if [ "$1" == "" ]; then
	showhelp=1
fi

if [ "$2" == "" ]; then
        showhelp=1
fi

if [ "$3" != "--stop" ] && [ "$3" != "--start" ] && [ "$3" != "--remove" ]  ; then

if [ "$3" == "" ]; then
        showhelp=1
fi
if [ "$4" == "" ]; then
        showhelp=1
fi
if [ "$5" == "" ]; then
        showhelp=1
fi
if [ "$showhelp" == "1" ]; then
	echo "Bad arguments"
	echo "Usage:"
	echo "	$0 MODELNAME APIPORT PASS1IMAGESIZE PASS2IMAGESIZE CHECKPOINT_NUM[--fg (debug)] "
	echo "	# CHECKPOINT_NUM = 15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300"
        echo "        # API PORT = 01-99 		"
	echo "-----------------------------------or-----------------"
	echo "Stop remove container"
	echo "  $0 MODELNAME CHECKPOINTNO --stop"
	exit 1
fi
fi


export modelname="$1"
export serverhostport=$2
export PASS1IMAGESIZE=$3
export PASS2IMAGESIZE=$4
export checkpointno="$5"

# Take care of cleaning the model name to fabric a pretty name for the container
replacerstr="model_gia-ds-"
secondString=""
modelnametmp=$modelname
tmpname="${modelnametmp/$replacerstr/$secondString}"
replacerstr="model_gia"
modelnametmp=$tmpname
tmpname="${modelnametmp/$replacerstr/$secondString}"
replacerstr="model_"
modelnametmp=$tmpname
tmpname="${modelnametmp/$replacerstr/$secondString}"
replacerstr="_new"
modelnametmp=$tmpname
tmpname="${modelnametmp/$replacerstr/$secondString}"
#export containername='ast_'$tmpname'_'$checkpointno'm_d2'
#echo mkcontainername $modelname $checkpointno 'ast_' 'm_d2'
#mkcontainername $modelname $checkpointno 'ast_' 'm_d2'
#exit
export containername=$(mkcontainername $modelname $checkpointno 'ast_' 'm_d2')

if [ "$3" == "--stop" ] ; then
	checkpointno=$serverhostport; containername=$(mkcontainername $modelname $checkpointno 'ast_' 'm_d2') ; (docker stop $containername$sslcontainersuffix &> /dev/null ; docker stop $containername &> /dev/null) && echo "$containername stopped"
	exit 0
fi
if [ "$3" == "--start" ] ; then
	checkpointno=$serverhostport; containername=$(mkcontainername $modelname $checkpointno 'ast_' 'm_d2') ; (docker start $containername  &> /dev/null ; docker start $containename$sslcontainersuffix   &> /dev/null)  && echo "$containername started" || \
		$0 $modelname $serverhostport $PASS1IMAGESIZE $PASS2IMAGESIZE $checkpointno # Launched this script to instal it as start did not worked
        exit 0
fi

if [ "$3" == "--rm" ] || [ "$3" == "--remove" ]; then
        checkpointno=$serverhostport; containername=$(mkcontainername $modelname $checkpointno 'ast_' 'm_d2') ;/a/bin/dkcRemove.sh $containername ; /a/bin/dkcRemove.sh $containername$sslcontainersuffix 
	exit 0
fi
 
source __launch-docker-dev-specific-checkpoint-doubletwo.210531.sh $6 $7



