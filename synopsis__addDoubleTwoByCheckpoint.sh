#!/bin/bash

export checkpointno=90
# export checkpointno="90 405 300"

export serverhostport=9070
export modelname=model_gia-ds-pierret_ds_210512-864-v02-210527-864_new
export PASS1IMAGESIZE=1200
export PASS2IMAGESIZE=1700


# ./addDoubleTwoChk.sh \
#     $port \
#     $modelname \
#     $PASS1IMAGESIZE $PASS2IMAGESIZE 


############################## BECAUSE WE ARE DEVELOPPING
export scriptfn=custom-cli-start-script-docker-dev-specific-checkpoint-doubletwo.210531.sh
#custom-cli-start-script-docker-dev-specific-checkpoint.210430.sh
#/a/src/rwml__adaptive_style_transfer/__launch-docker-dev-specific-checkpoint-doubletwo.210531.sh


source $scriptfn "$modelname" $serverhostport  $PASS1IMAGESIZE $PASS2IMAGESIZE $checkpointno $1

