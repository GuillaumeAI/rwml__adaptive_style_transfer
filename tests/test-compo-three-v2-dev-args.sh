#!/bin/bash

export requestFileContentImage=_request_raw.json
export infile=Sketch__2101240002__01_cc01-redraw.jpg

if [ "$4" == "" ];then
   echo "Infer a compo style with specific resolution "
   echo "the composite model three-v2-dev with custom resolution."
   echo "----------------------------"
   echo "USAGE :"
   echo "$0 [mid] [x1] [x2] [x3] ([vseq])"
   echo "vseq: used to bypass the sequencial number at the end. default is x1"
   echo "mid:  57,58"
   echo "-----By Guillaume Descoteaux-Isabelle,2021"
   exit
fi

#export req_contentImageFilePart=_contentImage.ojson
gia-ast-img2stylize-request $infile $requestFileContentImage

export callhost="as.guillaumeisabelle.com"
export callprotocol="http"
export callmethod="stylize"
export callportbase=90
export callport=$callportbase$modelid
export responseFile=response.json
export requestFile=sample-args.json
export callContentType="Content-Type: application/json"
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
export out_prefix="result_a_"
export out_ext=jpg
export filetag=$modelid'_'$v3l$v3'_'$v2l$v2p
export outfile=$out_prefix$filetag'_'$vseq.$out_ext
export req_p1='{"x1":'$x1',"x2":'$x2',"x3":'$x3','
#make the request file
echo "$req_p1" >$requestFile
#cat $req_contentImageFilePart >> $requestFile
cat $requestFileContentImage | tr "{" " " >> $requestFile
rm $requestFileContentImage
#echo "}" >> $requestFile
outdir='out_'$filetag
mkdir -p $outdir

export callurl="$callprotocol://$callhost:$callport$modelid/$callmethod"

# Call the modeling service
#curl --header  "$callContentType"  --request POST   --data @$requestFile $callurl --output $responseFile --silent
echo curl --header  "$callContentType"  --request POST   --data @$requestFile $callurl --output $responseFile

curl --header  "$callContentType"  --request POST   --data @$requestFile $callurl --output $responseFile

#convert the response
gia-ast-response-stylizedImage2file response.json $outfile
mv $outfile $outdir
echo "$outfile created and moved in $outdir"

