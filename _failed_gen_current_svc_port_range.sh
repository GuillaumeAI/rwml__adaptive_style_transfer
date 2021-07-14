#(cd /a/src/rwml__adaptive_style_transfer;./_adm__stopRemove_Containers__210502.sh --list --port  | sort|tr ":" " " | awk '/90/ {print substr($1,3)  " #"$2}'  )

if [ "$1" == "" ] ; then
	echo "Usage : $0 <cmd> <file> \"<args>\" \"<comments\">"
	echo "ie.: . _failed_gen_current_svc_port_range.sh gia-ast-meta Sketch__2101240002__01_cc01-redraw.jpg \"380 2048 -1\""
	exit 1
fi

containers=$(cd /a/src/rwml__adaptive_style_transfer;./_adm__stopRemove_Containers__210502.sh --list --port  | sort| awk '/90/')



for c in $containers ; do 
	p=$(echo $c | tr ":" " " | awk '/90/ {print substr($1,3)}')
	#echo "p=$p"
	#echo "----"
	n=$(echo $c | tr ":" " " | awk '/90/ {print $2}')
	#echo "n=$n"
	#echo "---"
	#" #"$2}'  )
	#echo "$1 $p $2 # $n $3"
	echo "$1 $2 $p $3 # $n $4"

done




