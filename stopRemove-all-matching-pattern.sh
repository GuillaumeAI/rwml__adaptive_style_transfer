#!/bin/bash


#@STCGoal Stop and removed matching pattern Service
if [ "$1" == "" ]; then 
	echo "usage: $0 <svc-pattern-to-match>"
	echo "$0 ast_ds-GabrielleKelly"
	exit 1
fi
#if [ ! "$(dkcrm)" ] ; then . $HOME/.bash_aliases; fi
#echo no; else echo ya ; fi
#if [ ! "$(dkcrm)" ] ; then echo no; else echo ya ; fi
#exit
source $binroot/__fn.sh
dkcrm=/a/bin/dkcRemove.sh

#s="./_adm__stopRemove_Containers__210502.sh --list --port | sort"
r=$(./_adm__stopRemove_Containers__210502.sh --list |grep "$1" | tr ":" " " | awk '// {print $1}')
echo "Processing : $r"

for l in $r; do echo "$l";$dkcrm $l;done
