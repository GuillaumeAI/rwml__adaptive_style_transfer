echo "INCOMPLETED I dont like it"

exit
start=50
end=30
c=$start
s=./test-compo-three-v2-dev-args.sh
for i in $(seq $start $end)
do
	echo "-----------$i------------"
	source _crop.sh $1 $2 $i
	$s 98 640 512 1024 $c
	c=$(expr $c + 1)
done	

#
#convert $1 -set page -%[fx:w*0.1]-%[fx:h*0.1] -crop $3%x+0+0 $2
