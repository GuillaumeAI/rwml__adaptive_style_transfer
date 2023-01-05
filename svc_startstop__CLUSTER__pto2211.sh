desiredstate=stop

if [ "$1" == "start" ]; then desiredstate=start;fi
if [ "$1" == "--start" ]; then desiredstate=start;fi
if [ "$1" == "--run" ]; then desiredstate=start;fi
if [ "$1" == "--rm" ]; then desiredstate=rm;fi

. __rwfn.sh

m=model_gia-ds-Inktobers-v01-210611-864x_new
if [ "$2" != "" ]; then m="$2";fi

suffix=m_d2
if [ "$3" != "" ]; then suffix="$3";fi
#$(mckinfo $m)
#cnamebase=$(mkcontainername $m)
cnamebase=$(getcontainernamefrommodel $m _d2 ast_)
#cnamebase=$(getfnamefrommodel $m)
#echo $cname
for chp in $(mckinfo $m)
do
	if [ "$chp" == "30015" ];then echo " "
	else
	cname=$cnamebase$chp$suffix
	#docker $desiredstate ast_Inktobers-v01-210611-864x_405m_d2
	$doecho docker $desiredstate $cname

	fi
done

