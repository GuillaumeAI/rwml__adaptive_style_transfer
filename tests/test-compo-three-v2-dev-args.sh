#!/bin/bash
source _env.sh

#export infile=Sketch__2101240002__01_cc01-redraw.jpg

# export infile=mycrop.jpg
# outdir_prefix='ocrop_'


if [ "$4" == "" ];then
   echo "Infer a compo style with specific resolution "
   echo "the composite model three-v2-dev with custom resolution."
   echo "----------------------------"
   echo "USAGE :"
   echo "$0 [mid] [x1] [x2] [x3] ([vseq]) [--droxul TARGET_FOLDER]"
   echo "vseq: used to bypass the sequencial number at the end. default is x1"
   echo "mid:  57,58"
   echo "-----By Guillaume Descoteaux-Isabelle,2021"
   exit
fi

if [ "$6" == "--droxul" ] && [ "$7" == "" ] ;then
   echo "--droxul require a base path where to upload the file"
   echo "--droxul /lib/results/compo-three-v2-dev"
   exit
fi
   
#export req_contentImageFilePart=_contentImage.ojson
$giaImg2Base64RequestScript $infile $requestFileContentImage --quiet

# export callhost="as.guillaumeisabelle.com"
# export callprotocol="http"
# export callmethod="stylize"
# export callportbase=90
export callport=$callportbase$modelid

export modelid=$1

export x1=$2
export x2=$3
export x3=$4
v1=$x1 #The one we alter
v1l=1x
v2=$x2
v2l=2x
v3=$x3
v3l=3x
#default seq number for FN or get it as optional args
vseq=$v1l
if [ "$5" != "" ];then
   vseq=$5
fi
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
#echo "}" >> $requestFile
outdir=$outdir_prefix$filetag

mkdir -p $outdir

export callurl="$callprotocol://$callhost:$callport$modelid/$callmethod"

# Call the modeling service
#curl --header  "$callContentType"  --request POST   --data @$requestFile $callurl --output $responseFile --silent
#echo curl --header  "$callContentType"  --request POST   --data @$requestFile $callurl --output $responseFile --silent
echo "------------------------------"
echo -n "Infering..."
(sleep 1;echo -n ".")
(sleep 1;echo -n ".")
(sleep 1;echo -n ".")
curl --header  "$callContentType"  --request POST   --data @$requestFile $callurl --output $responseFile --silent
echo -n "."
echo "done."
echo "------------------------------"
#convert the response
$giaAstResponseStylizedToFileScript $responseFile $outfile --quiet
mv $outfile $outdir
#######################
#store the vars for other process
echo "export lastoutfile=$outfile" >> $lastContextEnv
echo "export lastoutdir=$outdir" >> $lastContextEnv
echo "export lastfiletag=$filetag" >> $lastContextEnv
echo "export lastoutfilebase=$outfilebase" >> $lastContextEnv
echo "export lastout_ext=$out_ext" >> $lastContextEnv
###################

echo -n " Moving $outfile    to: $outdir"

if [ "$6" == "--droxul" ];then
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

echo "------------"
#sleep 1