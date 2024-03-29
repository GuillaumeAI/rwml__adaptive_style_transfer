#!/bin/bash

# Dev to mount specific checkpoint and launch an API Web service serving those checkpoints.


# script.sh MODEL_NAME APIPORT CHECKPOINT_NUM

source _env.sh
showhelp=0
if [ "$1" == "" ]; then
	showhelp=1
fi
if [ "$2" == "" ]; then
        showhelp=1
fi
if [ "$3" == "" ]; then
        showhelp=1
fi

if [ "$showhelp" == "1" ]; then
	echo "Bad arguments"
	echo "Usage:"
	echo "	$0 MODELNAME APIPORT CHECKPOINT_NUM"
	echo "	# CHECKPOINT_NUM = 15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300"
        echo "        # API PORT = 01-99 		"
	exit 1
fi



export modelname="$1"

export checkpointno=$3

# Take care of cleaning the model name to fabric a pretty name for the container
replacerstr="model_gia-ds-"
secondString=""
modelnametmp=$1
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
export containername='ast_'$tmpname'_'$checkpointno'm'
export serverhostport=$2


source __launch-docker-dev-specific-checkpoint.210430.sh
#source __launch-docker.sh

