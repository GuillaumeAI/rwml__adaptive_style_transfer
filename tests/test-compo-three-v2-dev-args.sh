#!/bin/bash
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
n=`printf %03d $x1`
export outfile=result-a-$modelid-$x3-$x2-$n.jpg
export req_p1='{"x1":'$x1',"x2":'$x2',"x3":'$x3','
export req_contentImageFilePart=_contentImage.ojson
#make the request file
echo "$req_p1">$requestFile
cat $req_contentImageFilePart >> $requestFile
echo "}" >> $requestFile

outdir='out-'$modelid'_'$x3'_'$x2
mkdir -p $outdir

export callurl="$callprotocol://$callhost:$callport$modelid/$callmethod"

# Call the modeling service
#curl --header  "$callContentType"  --request POST   --data @$requestFile $callurl --output $responseFile --silent
curl --header  "$callContentType"  --request POST   --data @$requestFile $callurl --output $responseFile

#convert the response
gia-ast-response-stylizedImage2file response.json $outfile
mv $outfile $outdir
echo "$outfile created and moved in $outdir"

