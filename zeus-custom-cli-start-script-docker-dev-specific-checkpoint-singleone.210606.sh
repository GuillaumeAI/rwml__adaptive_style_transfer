#!/bin/bash

# Dev to mount specific checkpoint and launch an API Web service serving those checkpoints.
source $binroot/__fn.sh

# script.sh MODEL_NAME APIPORT IMGSIZE1 IMGSIZE2 CHECKPOINT_NUM [--fg(debug)] 

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
if [ "$4" == "" ]; then
        showhelp=1
fi

if [ "$showhelp" == "1" ]; then
	echo "Bad arguments"
	echo "Usage:"
	echo "	$0 MODELNAME APIPORT PASS1IMAGESIZE CHECKPOINT_NUM [--fg (debug)] "
	echo "	# CHECKPOINT_NUM = 15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345 360 375 390 405"
        echo "        # API PORT = 01-99 		"
	exit 1
fi



export modelname="$1"
export serverhostport=$2
export PASS1IMAGESIZE=$3

export checkpointno="$4"

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
export containername='ast_'$tmpname'_'$checkpointno'm_s1_zeus'

export launcher_spec_singleone_script="zeus-__launch-docker-dev-specific-checkpoint-singleone.210606.sh"

echo "source $launcher_spec_singleone_script $5 $6"
source $launcher_spec_singleone_script $5 $6


