#!/bin/bash
#@STCGoal Mount a sequences of Checkpoints from one model into a batch of web api services
#@Usage: ./doubletwo-multi-cherkpoint-svc-mounter.sh model_ds-GabrielleKelly-v01-210624-864x_new 9060 1500 2000 "$(mckinfo model_ds-GabrielleKelly-v01-210624-864x_new)"



s=./custom-cli-start-script-docker-dev-specific-checkpoint-singleone.210606.sh
m=$1
p=$2
x1=$3
chks="$4"
if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ]  || [ "$4" == "" ]; then 
	echo "Single One Start Script"
	echo "By : J GUillaume Isabelle"
	echo "Usage: $s model_ds-GabrielleKelly-v01-210624-864x_new 9060 1500  \"$(mckinfo model_ds-GabrielleKelly-v01-210624-864x_new)\""
#	exit 1

else #We do process

for chp in $chks; do 
	echo "##############################################################################"
	echo "$chp-$p"
	echo 	$s $m $p $x1 $chp
	echo "=============================================================================="

 	if [ "$RUNINBG" != "" ] ; then 
		$s $m $p $x1 $chp &
		sleep 2
	else 
 		$s $m $p $x1 $chp 
	fi
	echo "------------------------------------------------------------------------------"
	p=$(expr $p + 1 )
	
done

fi
