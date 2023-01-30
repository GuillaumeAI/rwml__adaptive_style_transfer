
source _env.sh
source _fnc_callit.sh

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
#determine if we infer
infer=1

#export A="gaia.guillaumeisabelle.com"
export B="orko.guillaumeisabelle.com"
export A="orko.guillaumeisabelle.com"
export C="orko.guillaumeisabelle.com"
#export C="as.guillaumeisabelle.com"
droxflag="--droxul"
droxflag="--nodroxul"
arrHost=("$A" "$B" "$C")
export c=1
start=35
end=95
leng=$( expr $end - $start + 2)
max=$( expr $leng \* 10)
nbhost=3
maxHost=$( expr $max / $nbhost)
echo "max:$max"
echo "maxHost:$maxHost"
#Fill an array with available host to take the id when we distribute
carr=$nbhost
for i in $(seq $nbhost $maxHost)
do 
   arrHost[$carr]="$A"
   carr=$(expr $carr + 1)
   arrHost[$carr]="$B"
   carr=$(expr $carr + 1)
   arrHost[$carr]="$C"
   carr=$(expr $carr + 1)
done
echo "Filled host queue"
# Iterate the loop to read and print each array element
# carr=1
# for value in "${arrHost[@]}"
# do
#      echo "$carr: $value"
#      carr=$(expr $carr + 1)
# done
# echo "-------"
# echo "${arrHost[34]}"
# exit
fgproc=1
#turn to zero for multi host
doallfgprocessing=1

for i in $(seq $start $end)
do
   #sub percentage zoom 0.1,0.2,...
   for ii in $(seq 0 9)
   do    
      chost=${arrHost[c]}
      #echo "Chost : $chost"
      if [ "$chost" == "$A" ]; then fgproc="$doallfgprocessing";fi
      if [ "$chost" == "$C" ]; then fgproc="1";fi
      #echo "We know $fgproc"
      export cropfactor="$i.$ii"
      callit "$cropfactor" "$c" "$crpf" $cropscript "$ocf" "$infer" "$s" "$p" "$x1" "$x2" "$x3" "$droxflag" "$dropbox_root_dir" "$chost" "$fgproc"

   done
done
#0.0 AS
#0.1 OrkO
#0.2 Gaia
#0.3 A 
#0.4 O
#0.5 G
#0.6 A
#0.7 O
#0.8 G
#0.9 A