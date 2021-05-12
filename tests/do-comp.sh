#!/bin/bash
source _env.sh $6

#export infile=Sketch__2101240002__01_cc01-redraw.jpg
#sleep 1

# outdir_prefix='ocrop_'

export multihost=0
if [ "$9" != "" ];then
   export multihost=1
   # we use the host from the param so we can distribute
   export callhost=$9
   echo "Host is : $callhost"

fi

if [ "$5" == "" ];then
   echo "Infer a compo style with specific resolution "
   echo "the composite model three-v2-dev with custom resolution."
   echo "----------------------------"
   echo "USAGE :"
   echo "$0 <file> <mid> <x1> <x2> <x3> ([vseq]) [--droxul TARGET_FOLDER] [Host]"
   echo "vseq: used to bypass the sequencial number at the end. default is x1"
   echo "mid:  57,58"
   echo "-----By Guillaume Descoteaux-Isabelle,2021"
   exit
fi

if [ "$7" == "--droxul" ] && [ "$8" == "" ] ;then
   echo "--droxul require a base path where to upload the file"
   echo "--droxul /lib/results/compo-three-v2-dev"
   exit
fi
   
# export callhost="as.guillaumeisabelle.com"
# export callprotocol="http"
# export callmethod="stylize"
# export callportbase=90
export callport=$callportbase$modelid

export infile=$1
export modelid=$2

export x1=$3
export x2=$4
export x3=$5
v1=$x1 #The one we alter
v1l=1x
v2=$x2
v2l=2x
v3=$x3
v3l=3x
#default seq number for FN or get it as optional args
vseq=$v1l

if [ "$6" != "" ];then
   vseq=$6
fi
crpitemf=$crpf$vseq.jpg
crpitemf=$infile
#infilebasename=${infile%.*}
#crpitemf=$infilebasename$vseq.jpg


#State of the current host
hostcurrentstatefile=$TMP/$callhost.txt
#echo "tail -f $hostcurrentstatefile"
#sleep 1

echo "-----$vseq------" >> $hostcurrentstatefile
echo "$vseq:$(date)" >> $hostcurrentstatefile
echo "$callhost:$vseq>>" >> $hostcurrentstatefile


$giaImg2Base64RequestScript $crpitemf $requestFileContentImage --verbose
echo "Cleaning $crpitemf"
#rm $crpitemf 
sleep 1

vseq=`printf %03d $vseq`

v1p=`printf %03d $v1`
v2p=`printf %03d $v2`
v3p=`printf %03d $v3`

n=`printf %03d $v1`
export filetag=$modelid'_'$v3l$v3'_'$v2l$v2p

export outfilebase=$outfile_prefix$filetag'_'
export outfile=$outfilebase$vseq.$out_ext

export req_p1='{"x1":'$x1',"x2":'$x2',"x3":'$x3','
#make the request file
echo "$req_p1" >$requestFile
#cat $req_contentImageFilePart >> $requestFile
cat $requestFileContentImage | tr "{" " " >> $requestFile
rm $requestFileContentImage
echo "requestFile: $requestFile was just contructed"
#echo "}" >> $requestFile
outdir=$outdir_prefix$filetag

mkdir -p $outdir

export callurl="$callprotocol://$callhost:$callport$modelid/$callmethod"

echo "export lcallurl=$callurl" >> $lastContextEnv
# Call the modeling service
#curl --header  "$callContentType"  --request POST   --data @$requestFile $callurl --output $responseFile --silent
#echo curl --header  "$callContentType"  --request POST   --data @$requestFile $callurl --output $responseFile --silent
#echo 


echo -n "Infering...$vseq..."
(sleep 1;echo -n ".")&
(sleep 2;echo -n ".")&
(sleep 3;echo -n ".")&
#echo curl --header  "$callContentType"  --request POST   --data @$requestFile $callurl --output $responseFile --silent
curl --header  "$callContentType"  --request POST   --data @$requestFile $callurl --output $responseFile --silent
echo -n "."
echo "Cleaning $requestFile...."
rm $requestFile
echo  "..."
#echo "------------------------------"
#convert the response
echo $giaAstResponseStylizedToFileScript $responseFile $outfile --quiet
echo mv $outfile $outdir
exit
#echo "...$responseFile cleared"
rm $responseFile
#######################
#exit
#store the vars for other process
echo "export lastoutfile=$outfile" >> $lastContextEnv
echo "export lastoutdir=$outdir" >> $lastContextEnv
echo "export lastfiletag=$filetag" >> $lastContextEnv
echo "export lastoutfilebase=$outfilebase" >> $lastContextEnv
echo "export lastout_ext=$out_ext" >> $lastContextEnv
echo "export outfile=$outfile" >> $lastContextEnv
echo "export outdir=$outdir" >> $lastContextEnv
echo "export filetag=$filetag" >> $lastContextEnv
echo "export outfilebase=$outfilebase" >> $lastContextEnv
echo "export out_ext=$out_ext" >> $lastContextEnv
###################

echo -n " Moving $outfile   "
echo -n "...done"
#echo -n " Moving $outfile    to: $outdir"

if [ "$7" == "--droxul" ];then
   dxr=$7
   
   echo "export lastdxr=$dxr" >> $lastContextEnv
   dxt=$dxr/$outdir
   echo "export lastdxt=$dxt" >> $lastContextEnv
   #so we dont try to create it more than once on dropbox
   flag="$outdir/.droxulflag"
   if [ -e "$flag" ];then
      #Dir Already created already
      echo -n " "
   else  
      droxul -q mkdir $dxt
      echo "just to know" > $flag
   fi

   #executing the upload of the
   execcmd="droxul -q upload $outdir/$outfile $dxt"
   #echo $execcmd
   echo -n "Launching Droxul in bg..."
   ($execcmd) &
   echo "...done"
fi


echo "$vseq:$(date)" >> $hostcurrentstatefile
echo "$callhost:$vseq<<" >> $hostcurrentstatefile
echo "-----" >> $hostcurrentstatefile
#echo "------------"
#sleep 1
