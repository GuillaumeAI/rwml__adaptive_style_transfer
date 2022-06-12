dxr=/lib/results/compo-three-v2-dev
x2=1024
x3=1792
p=98
fp=$x3'_'$x2
#dxt=$dxr'/out_'$fp
#droxul mIkdir $dxt
start=1
end=140
s=./test-compo-three-v2-dev-args.sh
sr=96;st=4;c=1
for i in $(seq $start $end) ; do 
	execcmd="$s $p $sr $x2 $x3 $c --droxul $dxr"
	$execcmd
	c=$(expr $c + 1);sr=$(expr $sr + $st)
	
	echo "$c of $end"
	#sleep 1
done

