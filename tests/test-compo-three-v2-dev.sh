#!/bin/bash
export callhost="as.guillaumeisabelle.com"
export callprotocol="http"
export callmethod="stylize"
export callportbase=90
export callport=$callportbase$modelid
export responseFile=response.json
export requestFile=sample.json
export callContentType="Content-Type: application/json"

export callurl="$callprotocol://$callhost:$callport$1/$callmethod"

# Call the modeling service
#curl --header  "$callContentType"  --request POST   --data @$requestFile $callurl --output $responseFile --silent
curl --header  "$callContentType"  --request POST   --data @$requestFile $callurl --output $responseFile

#convert the response
gia-ast-response-stylizedImage2file response.json result-$1.jpg
echo "result-$1.jpg created"

