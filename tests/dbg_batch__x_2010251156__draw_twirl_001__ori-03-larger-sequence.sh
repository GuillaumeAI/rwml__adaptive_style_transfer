#Multiple iteration small creation using iteration 315K of the dbgv01b model
#@STCGoal An end result and a sequence of those multiple size

f=x_2010251156__draw_twirl_001__ori.jpg
dttag=$(date +'%y%m%d%H%M%S')
endresultdir=/a/lib/results/gia-ds-DavidBouchardGagnon-v01b-210510-864/x__315m/$dttag
secdir=$endresultdir/seq

mkdir -p $secdir || (echo "could not create or access $endresultdir"; exit 1)

s=./do-comp.sh
export SKIPFEH=1
p=37
minrez=200
inc=5
lastrez=2700
c=0
if [ "$1" != "--restart" ]; then #We start from scratch
	echo "Restarting from original source $f"
	sleep 1
	if [ "$2" != "" ] ;then # a res was spec
		minrez=$2
	fi
	ft=`printf %04d $c`
	convert -geometry $lastrez'x' $f $secdir/$ft'.jpg'  &
	c=$(expr $c + 1)

	$s $f $p $minrez 0

 	
fi
 # That is our first image in the  sequence
. OUTPATH
ft=`printf %02d $c`
convert -geometry $lastrez'x' $OUTPATH $secdir/$ft'.jpg'  &
c=$(expr $c + 1)


for i in $(seq $minrez $inc $lastrez) ; do
	echo "------------Processing $i-------------"
	$s $OUTPATH $p $i 0 &> /dev/null && \
	. OUTPATH

	ft=`printf %02d $c`
	#cp $OUTPATH $ft'.jpg'
	(convert -geometry $lastrez'x' $OUTPATH $secdir/$ft'.jpg'  &&  \
		feh -F $secdir/$ft'.jpg')	 &
        
	c=$(expr $c + 1)
done
sleep 1
. OUTPATH

echo "-------------------------------"
echo "Final result is : $OUTPATH"
echo "--------------------------------------------"
tpath=$endresultdir/ENDRESULT__$dttag.jpg

cp $OUTPATH $tpath
echo "Sequence is in : $secdir"
echo "Final result dist: $tpath"

