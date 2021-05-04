x1=1368
x2=1024
x3=2048
p=98
s=./test-compo-three-v2-dev-args.sh
for i in {5..99}
do
	echo "-----------$i------------"
	source _crop.sh $1 $2 $i
	$s $p $x1 $x2 $x3 $i
done	
#convert $1 -set page -%[fx:w*0.1]-%[fx:h*0.1] -crop $3%x+0+0 $2
