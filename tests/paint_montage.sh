
#run from the dir where the files are
contentbase=sc_2105242108_c__
stylizedbase=result_a_98_3x1788_2x1111_001_s__
outbase=xsc_2105242108__
for i in {1..106} ; do 
	padded=$(printf "%05d\n" $i)
	mkdir -p CP
	montage $contentbase$padded'.jpg' $stylizedbase$padded'.jpg' -geometry +100+0 'CP/'$outbase$padded'.jpg'  
done

