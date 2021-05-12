
function callit() {
   #  i=$1; c=$2
   #  crpf=$3; cropscript=$4; ocf=$5
   #  infer=$6; s=$7
   #  p=$8;  x1=$9
   #  x2="${10}"; x3="${11}"
   #  droxflag="${12}"
   #  dropbox_root_dir="${13}"
   #  chost="${14}"
   
	echo "#-----------i:$i--c:$c-----"
   crpitemf=$crpf$c.jpg
   #croping
   echo "## Cropfactor: $cropfactor"
   source $cropscript $ocf $crpitemf $cropfactor
   #inference  
   cmdexec="$s $p $x1 $x2 $x3 $c $droxflag $dropbox_root_dir $chost"
   #fg or bg exec
	if [ "$fgproc" == "1" ] ; then 
      $cmdexec
      source _sleeper_loop.sh
   else 
      echo "Launching in BG"
      $cmdexec     & 
   fi
	c=$(expr $c + 1)
}