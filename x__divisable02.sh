#!/bin/bash

isdiv() {
	n=$1 
	read -p "Enter a number " number    # read can output the prompt for you.
      	if (( $number % $n == 0 ))           # no need for brackets
	then
		dividable=1
    		#echo "Your number is divisible by $n"
	else
		dividable=0
    		#echo "Your number is not divisible by $n"
	fi
	}
isdiv $1 
echo $dividable

