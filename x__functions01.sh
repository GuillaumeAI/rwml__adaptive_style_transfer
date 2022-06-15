#!/bin/bash


hehe () {
	echo "hello $1"
	hehe_result=hey
}

hehe JEO

echo $hehe_result

f="$(hehe)"
echo $f
