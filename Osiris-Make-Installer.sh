
. _env.sh
ob=osiris-doubletwo.sh
o=$ob-installer
ou=$ob-uninstaller

echo "s=./custom-cli-start-script-docker-dev-specific-checkpoint-doubletwo.210531.sh" > $o

curport=9060
c=0
x1=500
x2=700
echo "curport=$curport" >> $o
echo "x1=$x1" >> $o
echo "x2=$x2" >> $o
cat $o > $ou

for m in $(./getAllModels.sh );do 
	ckp=$($binroot/mckinfo.sh $m)
	echo "\$s $m \$(expr \$curport + $c ) \$x1 \$x2 $ckp" >> $o; echo "$s $m $ckp --stop" >> $ou;c=$(expr $c + 1)
done
