source _env.sh
#source _init.sh


ocf=$1
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
c=94
#determine if we infer
infer=1

export A="gaia.guillaumeisabelle.com"
export B="orko.guillaumeisabelle.com"
export C="as.guillaumeisabelle.com"
droxflag="--droxul"
droxflag="--nodroxul"
for i in {46..99}
do
	
	echo "#-----------i:$i--c:$c-------------"
   crpitemf=$crpf$c.jpg
		source $cropscript $ocf $crpitemf $i  
	if [ "$infer" == "1" ] ; then 
      $s $p $x1 $x2 $x3 $c $droxflag $dropbox_root_dir $A &
   fi
	c=$(expr $c + 1)
	echo "#-----------i:$i--c:$c-------------"
   crpitemf=$crpf$c.jpg
	source $cropscript $ocf $crpitemf $i.33  
	if [ "$infer" == "1" ] ; then 
      $s $p $x1 $x2 $x3 $c $droxflag $dropbox_root_dir $B &
   fi
	c=$(expr $c + 1)
	source _sleeper_loop_mid.sh
	echo "#-----------i:$i--c:$c-------------"
	crpitemf=$crpf$c.jpg
	source $cropscript $ocf $crpitemf $i.67
	if [ "$infer" == "1" ] ; then 
                $s $p $x1 $x2 $x3 $c $droxflag $dropbox_root_dir $C
   fi
	c=$(expr $c + 1)
   #sleep 3
	
	source _sleeper_loop.sh

done	


w=1;source $lastContextEnv
#convert $ocf -set page -%[fx:w*0.1]-%[fx:h*0.1] -crop $3%x+0+0 $crpf
