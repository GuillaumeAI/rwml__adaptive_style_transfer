
#@STCGoal Generate D2 Install Script for Osiris Host (Cloud machine) 
#@STCStatus Existing generated script osiris-doubletwo.sh-****

. _env.sh
ob=osiris-doubletwo.sh
o=$ob-installer
ou=$ob-uninstaller

echo "s=./custom-cli-start-script-docker-dev-specific-checkpoint-doubletwo.210531.sh" > $o
echo "cmd=\$1" >> $o
echo "if [ \"\$cmd\" == \"\" ] ; then echo \"usage: \$0 <--stop|--start|--remove>\";exit 1;fi " >> $o

curport=9060
c=0
x1=2300
x2=2700
echo "curport=$curport" >> $o
echo "x1=$x1" >> $o
echo "x2=$x2" >> $o
cat $o > $ou

for m in $(./getAllModels.sh );do 
	ckp=$($binroot/mckinfo.sh $m)
	echo "\$s $m \$(expr \$curport + $c ) \$x1 \$x2 $ckp" >> $o; echo "\$s $m $ckp \$cmd" >> $ou;c=$(expr $c + 1)
done
chmod +x $o $ou
