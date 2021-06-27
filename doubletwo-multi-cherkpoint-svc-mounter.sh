#!/bin/bash

s=./custom-cli-start-script-docker-dev-specific-checkpoint-doubletwo.210531.sh
m=$1
p=$2
x1=$3
x2=$4
chks="$5"

for chp in $chks; do 
	echo "$chp-$p"
echo 	$s $m $p $x1 $x2 $chp
 	$s $m $p $x1 $x2 $chp
	p=$(expr $p + 1 )
done

