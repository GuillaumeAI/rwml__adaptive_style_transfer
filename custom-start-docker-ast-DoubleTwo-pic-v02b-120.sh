#!/bin/bash

#export checkpointno=90
export checkpointno="90 405 300"
export checkpointno="45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345 360 375 390 405"
export checkpointno="15 30 45 60 75 90 105 120 135 150 165"
export checkpointno="315 330 345 360 375 390 405"
#keep only good
export checkpointno="120"

export serverhostport=9040
export modelname=model_gia-young-picasso-v02b-201210-864_new
export modelname=model_gia-young-picasso-v02b-201210-864_new-120ik
export PASS1IMAGESIZE=1333
export PASS2IMAGESIZE=2333


# ./addDoubleTwoChk.sh \
#     $port \
#     $modelname \
#     $PASS1IMAGESIZE $PASS2IMAGESIZE 


############################## BECAUSE WE ARE DEVELOPPING
export scriptfntocall=custom-cli-start-script-docker-dev-specific-checkpoint-doubletwo.210531.sh
#custom-cli-start-script-docker-dev-specific-checkpoint.210430.sh
#/a/src/rwml__adaptive_style_transfer/__launch-docker-dev-specific-checkpoint-doubletwo.210531.sh
export dkcrmflag="$2"
for c in $checkpointno ; do
    echo $c
    source $scriptfntocall "$modelname" $serverhostport \
    $PASS1IMAGESIZE $PASS2IMAGESIZE \
    $c "$1" "$dkcrm"

    sleep 1
    export serverhostport=$(expr $serverhostport + 1)
done


