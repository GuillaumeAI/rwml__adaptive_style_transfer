#!/bin/bash

if [ "$4" == "" ];then 
	echo "Usage: $0 <model> <s1-fullport> <chk> [res]"
else
m=$1


res1=2000
if [ "$4" != "" ]; then res1=$4;fi

ps=$2
ck=$3

#./d2-run-one $m $ps $ck



./singleone-multi-cherkpoint-svc-mounter.sh $m $ps $res1 $ck


fi

