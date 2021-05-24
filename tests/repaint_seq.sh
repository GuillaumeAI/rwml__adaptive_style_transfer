
# This enable painting and manually saving to have an inference made every X time.

c=sc_2105242108.jpg
midport=97
x1=777
x2=1111
x3=1788
waiting=5
for i in {1..106} ;do 
	./do-comp.sh $c $midport $x1 $x1 $x3 ; .  OUTPATH ;f=$(basename $OUTPATH);ff=${f%.*}
	padded=$(printf "%05d\n" $i)
	cp $OUTPATH $d/$ff'_s__'$padded'.jpg'
	
	#content
	ff=${c%.*};cp $c $d/$ff'_c__'$padded'.jpg';echo "Next in $waiting";
	
	sleep $waiting
done


