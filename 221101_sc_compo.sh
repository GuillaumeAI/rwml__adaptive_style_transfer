#!/bin/bash

s=custom-cli-start-script-docker-dev-specific-checkpoint-singleone.210606.sh

#  MODELNAME APIPORT PASS1IMAGESIZE CHECKPOINT_NUM [--fg (debug)]
m=model_gia-ds-Inktobers-v01-210611-864x_new
m=model_gia-ds-dbginko-v03-210809-864x_new
s=01

for c in 15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345 360 375 390 405 420 435 450 465 480 495 510 525 540 555 570
do
	echo "Installing ----$c ->  $m"
	source $s $m $s 2048 $c
	echo "---------------------------------------"
done

# 2
m=model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new
s=60

for c in 15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345 360 375 390 405 420 435
do
        echo "Installing ----$c ->  $m"
        source $s $m $s 2048 $c
        echo "---------------------------------------"
done
#$s $m 60 2048 "15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345 360 375 390 405 435"
