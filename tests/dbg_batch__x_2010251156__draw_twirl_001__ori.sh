#Multiple iteration small creation using iteration 315K of the dbgv01b model
f=x_2010251156__draw_twirl_001__ori.jpg
s=./do-comp.sh
p=37
#$s $f $p 500 1000
. OUTPATH
for i in 600 800 1000 1200 1400 1600 1800 1900 2100 2250 2375 2450 2550; do
	$s $OUTPATH $p $i 0
	. OUTPATH
done
. OUTPATH
echo "-------------------------------"
echo "Final result is : $OUTPATH"

