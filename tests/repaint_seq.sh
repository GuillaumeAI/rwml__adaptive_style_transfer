
# This enable re painting a sequence you have painted using a different inference made every X time.

d=xsc_21052422$1 #where our experiment workdir is
mkdir -p $d/CP
#c=sc_2105242108.jpg
if [ "$1" == "" ] ; then echo "Usage : $0 mport";exit 1
fi

#current baselocation of out sequences
cbasefullpath=xsc_2105242108/sc_2105242108_c__
midport=$1 #out target modelid port
x1=777 #first res in
x2=1111 #second res
x3=1788 #third res


for i in {1..106} ;do 
	
	#know out content from the source sequence existing
	padded=$(printf "%05d\n" $i)
	c=$cbasefullpath$padded'.jpg'
	#inferences
	if [ -e $c ] ; then
		./do-comp.sh $c $midport $x1 $x1 $x3 ; .  OUTPATH ;f=$(basename $OUTPATH);ff=${f%.*}
		#make a copy in the sequence
		stylizedoutrelpath=$d/$ff'_s__'$padded'.jpg' 
		cp $OUTPATH $stylizedoutrelpath
 		
		#content ya make another copy of out content in the new dir so we have it with us
		cp $c $d/$ff'_c__'$padded'.jpg'

		#do a montage 
		montage $c $stylizedoutrelpath -geometry +100+0 $d'/CP/'$outbase$padded'.jpg'	
	else
		echo "hummm $c does not exist"
	fi
done


