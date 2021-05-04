source _env.sh
#source _init.sh

dropbox_root_dir=/lib/results/compo-three-v2-dev

#test
x1=24
x2=32
x3=48
#prod
x1=1368
x2=1024
x3=2048

p=98
s=./test-compo-three-v2-dev-args.sh
c=5
#determine if we infer
infer=1
for i in {5..50}
do
	echo "-----------i:$i--c:$c-------------"
	source _crop.sh $1 $2 $i
	if [ "$infer" == "1" ] ; then $s $p $x1 $x2 $x3 $c --droxul $dropbox_root_dir ; fi
	c=$(expr $c + 1)

done	

w=1;source $lastContextEnv
for i in {50..35}
do
        echo "cp----------i:$i--c:$c-------------"
	#echo "Copying $lastoutfilebase from $lastoutdir"
	ii=`printf %03d $i`
	c=$(expr $c + 1)
	cc=`printf %03d $c`
	#using frames we have and add them at the end of the sequence
	ft=$lastoutdir/$lastoutfilebase$cc.$lastout_ext
	fs=$lastoutdir/$lastoutfilebase$ii.$lastout_ext ; cp $fs $ft ; echo "$fs to $ft"
	if [ -e "$ft" ]; then 
        (sleep $w;droxul -q upload $ft $lastdxt;w=$(expr $w + 1)) &
        fi
		
done
for i in {35..50}
do
        echo "cp----------i:$i--c:$c-------------"
        #echo "Copying $lastoutfilebase from $lastoutdir"
        ii=`printf %03d $i`
        c=$(expr $c + 1)
        cc=`printf %03d $c`
        #using frames we have and add them at the end of the sequence
       ft=$lastoutdir/$lastoutfilebase$cc.$lastout_ext        
       fs=$lastoutdir/$lastoutfilebase$ii.$lastout_ext ; cp $fs $ft ; echo "$fs to $ft"
        if [ -e "$ft" ]; then 
        (sleep $w;droxul -q upload $ft $lastdxt;w=$(expr $w + 1)) &
        fi 

done
for i in {51..80}
do
        echo "-----------i:$i--c:$c-------------"
        source _crop.sh $1 $2 $i
        if [ "$infer" == "1" ] ; then $s $p $x1 $x2 $x3 $c --droxul $dropbox_root_dir; fi
        c=$(expr $c + 1)

done
#source _init.sh
w=1;source $lastContextEnv
for i in {80..58}
do
        echo "cp----------i:$i--c:$c-------------"
        #echo "Copying $lastoutfilebase from $lastoutdir"
        ii=`printf %03d $i`
        c=$(expr $c + 1)
        cc=`printf %03d $c`
        #using frames we have and add them at the end of the sequence
      ft=$lastoutdir/$lastoutfilebase$cc.$lastout_ext        
      fs=$lastoutdir/$lastoutfilebase$ii.$lastout_ext ; cp $fs $ft ; echo "$fs to $ft"
        if [ -e "$ft" ]; then 
        (sleep $w;droxul -q upload $ft $lastdxt;w=$(expr $w + 1)) &
        fi

done

for i in {58..80}
do
        echo "cp----------i:$i--c:$c-------------"
        #echo "Copying $lastoutfilebase from $lastoutdir"
        ii=`printf %03d $i`
        c=$(expr $c + 1)
        cc=`printf %03d $c`
        #using frames we have and add them at the end of the sequence
     ft=$lastoutdir/$lastoutfilebase$cc.$lastout_ext        
     fs=$lastoutdir/$lastoutfilebase$ii.$lastout_ext ; cp $fs $ft ; echo "$fs to $ft"
        if [ -e "$ft" ]; then 
        (sleep $w;droxul -q upload $ft $lastdxt;w=$(expr $w + 1)) &
        fi

done
#source _init.sh
for i in {81..96}
do
        echo "-----------i:$i--c:$c-------------"
        source _crop.sh $1 $2 $i
        if [ "$infer" == "1" ] ; then $s $p $x1 $x2 $x3 $c --droxul $dropbox_root_dir ; fi
        c=$(expr $c + 1)

done
w=1;source $lastContextEnv
for i in {96..85}
do
        echo "cp----------i:$i--c:$c-------------"
        #echo "Copying $lastoutfilebase from $lastoutdir"
        ii=`printf %03d $i`
        c=$(expr $c + 1)
        cc=`printf %03d $c`
        #using frames we have and add them at the end of the sequence
      ft=$lastoutdir/$lastoutfilebase$cc.$lastout_ext        
      fs=$lastoutdir/$lastoutfilebase$ii.$lastout_ext ; cp $fs $ft ; echo "$fs to $ft"
        if [ -e "$ft" ]; then 
        (sleep $w;droxul -q upload $ft $lastdxt;w=$(expr $w + 1)) &
         fi
done

for i in {85..96}
do
        echo "cp----------i:$i--c:$c-------------"
        #echo "Copying $lastoutfilebase from $lastoutdir"
        ii=`printf %03d $i`
        c=$(expr $c + 1)
        cc=`printf %03d $c`
        #using frames we have and add them at the end of the sequence
       ft=$lastoutdir/$lastoutfilebase$cc.$lastout_ext        
       fs=$lastoutdir/$lastoutfilebase$ii.$lastout_ext ; cp $fs $ft ; echo "$fs to $ft"

        if [ -e "$ft" ]; then
        (sleep $w;droxul -q upload $ft $lastdxt;w=$(expr $w + 1)) &
         fi
done

#source _init.sh
for i in {97..100}
do
        echo "-----------i:$i--c:$c-------------"
        source _crop.sh $1 $2 $i
        if [ "$infer" == "1" ] ; then $s $p $x1 $x2 $x3 $c --droxul $dropbox_root_dir; fi
        c=$(expr $c + 1)

done
w=1;source $lastContextEnv
#convert $1 -set page -%[fx:w*0.1]-%[fx:h*0.1] -crop $3%x+0+0 $2
