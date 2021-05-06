#echo -n "Cropping $3"
convert $1 -set page -%[fx:w*0.1]-%[fx:h*0.1] -crop $3%x+0+0 $2
#sleep 1
#echo "...done saved: $2"
