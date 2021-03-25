

# Ran by another script that preped all we need

export docker_cmd="docker run -$docker_mode --rm "
if [ $docker_mode = "d" ] ; then echo "Background infrastructure mode activated (will run in background until stopped or server rebooted)" ; fi
if [ $docker_mode = "it" ] ; then echo "Foreground infrastructure mode activated (require to keep the startup shell active)" ; fi


export callurl="$callprotocol://$hostdns:$serverhostport"

export modelmountpoint="$containermodelroot/$modelname/checkpoint_long"
export modellocalpoint="$modelmountpath/$modelname/checkpoint_long"

echo "-------------------------------------------------------------"
echo "-            Running  Guillaume's M.A. AI Model Server      -"
echo "- Model Name: $modelname"
echo "- AccessURL : $callurl"
echo "-------------------------------------------------------------"
#$docker_cmd -v $(pwd):/work -p 8000:9000 -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd
echo $docker_cmd -v $(pwd):/work  -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport -e SPORT=$serverhostport $containertag
sleep 2
$docker_cmd -v $(pwd):/work  -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport -e SPORT=$serverhostport $containertag

