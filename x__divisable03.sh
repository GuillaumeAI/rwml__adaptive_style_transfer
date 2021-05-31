#!/bin/bash

isdiv() {
	number=$1
	n=2
	#read -p "Enter a number " number    # read can output the prompt for you.
      	if (( $number % $n == 0 ))           # no need for brackets
	then
		dividable=1
    		#echo "Your number is divisible by $n"
	else
		dividable=0
    		#echo "Your number is not divisible by $n"
	fi
	}
c=1
r=1
for i in {1..50}; do

	isdiv $i	
	#echo -n "$dividable "
	# I can crop subframes, I dont need modulo I thkni, just functions
	cc=`printf %03d $c`
	echo $cc $r
	c=$(expr $c + 1)
	ii=$r.5
	cc=`printf %03d $c`
        echo $cc $ii
	c=$(expr $c + 1)

	r=$(expr $r + 1)

done
echo "All great"

