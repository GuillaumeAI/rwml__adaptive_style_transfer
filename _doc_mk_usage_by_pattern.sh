#!/bin/bash

. _env.sh
# . $binroot/etc/bash_env_common
# . $binroot/etc/bash_aliases_common
export mdtableheader='|       |       |       |
|  ---  |  ---  |  ---  |'
#Make doc for usage

## Pattern to list
kw=$1
if [ "$1" == "" ]; then echo "Usage: $0 <pattern2Search>" ; 
else

ext=sh
(echo "## $kw";\
	echo "$mdtableheader";\
	for f in $(ls *$ext| grep $kw) ; do \
		fstcgoal=$(cat $f | grep STCGoal| sed -e 's/\#\@/--@/') ;\
		fstcstatus=$(cat $f | grep STCStatus| sed -e 's/\#\@/--@/') ;\
	echo '|'"[$f]($f)"'|    |'"$fstcgoal"'  |';\
	echo '|     | '"$fstcstatus"'    |     |' ;\
	done) >> USAGE.md

fi
