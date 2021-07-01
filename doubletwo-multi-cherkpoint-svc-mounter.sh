#!/bin/bash
#@STCGoal Mount a sequences of Checkpoints from one model into a batch of web api services
#@Usage: ./doubletwo-multi-cherkpoint-svc-mounter.sh model_ds-GabrielleKelly-v01-210624-864x_new 9060 1500 2000 "$(mckinfo model_ds-GabrielleKelly-v01-210624-864x_new)"


s=./custom-cli-start-script-docker-dev-specific-checkpoint-doubletwo.210531.sh
m=$1
p=$2
x1=$3
x2=$4
chks="$5"
if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ] || [ "$4" == "" ] || [ "$5" == "" ]; then 
	echo "Usage: ./doubletwo-multi-cherkpoint-svc-mounter.sh model_ds-GabrielleKelly-v01-210624-864x_new 9060 1500 2000 \"$(mckinfo model_ds-GabrielleKelly-v01-210624-864x_new)\""
	exit 1
fi


for chp in $chks; do 
	echo "$chp-$p"
echo 	$s $m $p $x1 $x2 $chp
 	$s $m $p $x1 $x2 $chp &
	p=$(expr $p + 1 )
	sleep 2
done

