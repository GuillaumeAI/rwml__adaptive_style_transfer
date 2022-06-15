#!/bin/bash

# script.sh MODEL_NAME 

source _env.sh


export modelname="$1"

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

export containername='ast_'$tmpname
export serverhostport=$2


source __launch-docker.sh

