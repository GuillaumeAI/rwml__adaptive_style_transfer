#!/bin/bash

export checkpointno=90
export port=9070
export modelname=model_gia-ds-pierret_ds_210512-864-v02-210527-864_new
export PASS1IMAGESIZE=1200
export PASS2IMAGESIZE=1700

./addDoubleTwoChk.sh \
    $port \
    $modelname \
    $PASS1IMAGESIZE $PASS2IMAGESIZE 
