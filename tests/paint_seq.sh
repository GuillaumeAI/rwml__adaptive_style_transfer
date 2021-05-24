
# This enable painting and manually saving to have an inference made every X time.

c=sc_2105242108.jpg

for i in {92..120} ;do 
	./do-comp.sh $c 98 777 1111 1788 ; . OUTPATH ;f=$(basename $OUTPATH);ff=${f%.*}
	padded=$(printf "%05d\n" $i)
	cp $OUTPATH $d/$ff'_s__'$padded'.jpg'
	
	#content
	ff=${c%.*};cp $c $d/$ff'_c__'$padded'.jpg';echo next in 17;
	
	sleep 4
done


