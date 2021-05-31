#!/bin/bash
read -p "Enter a number " number    # read can output the prompt for you.
if (( $number % 5 == 0 ))           # no need for brackets
then
    echo "Your number is divisible by 5"
else
    echo "Your number is not divisible by 5"
fi

