#!/bin/bash
echo "entening"

if [ "$5" == "" ];then
   echo "Render a sequence of inferences using "
   echo "the composite model three-v2-dev with custom resolution."
   echo "----------------------------"
   echo "USAGE :"
   echo "$0 [mid] [x1] [x2] [x3] [SeqLenght] ([Increment(def:1)])"
   echo "-----By Guillaume Descoteaux-Isabelle,2021"
   exit
fi
modelid=$1
x1=$2
x2=$3
x3=$4
start=$x1
seq=$5
echo "------6:$6"
export inc=1

if [ "$6" != "" ];then
   export inc=$6
fi

echo "---Increment: $inc---"


end=$( expr $start + $seq )

s=./test-compo-three-v2-dev-args.sh
echo "$modelid $x1 $x2 $x3 $end"
c=$start
for i in $(seq $start $end)
do 
   echo "----------------$i:$c---------------------"
   execcmd="$s $modelid $c $x2 $x3 $i"
   echo $execcmd
   $execcmd

   c=$( expr $c + $inc)
done
