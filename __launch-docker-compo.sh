

# Ran by another script that preped all we need

export docker_cmd="docker run -$docker_mode $docker_run_args --name $containername "

if [ $docker_mode = "d" ] ; then echo "Background infrastructure mode activated (will run in background until stopped or server rebooted)" ; fi
if [ $docker_mode = "it" ] ; then echo "Foreground infrastructure mode activated (require to keep the startup shell active)" ; fi


export callurl="$callprotocol://$hostdns:$serverhostport"

export modelmountpoint="$containermodelroot/$modelname/checkpoint_long"
export model2mountpoint="$containermodelroot/$model2name/checkpoint_long"
export modellocalpoint="$modelmountpath/$modelname/checkpoint_long"
export model2localpoint="$modelmountpath/$model2name/checkpoint_long"

echo "-------------------------------------------------------------"
echo "- Running  Guillaume's M.A. AI AST Compo Model Server      -"
echo "- Model Name: $modelname"
echo "- Model2 Name: $model2name"
echo "- AccessURL : $callurl"
echo "-------------------------------------------------------------"
#$docker_cmd -v $(pwd):/work -p 8000:9000 -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd
echo "----------Cleaning up $containername-------"
docker stop $containername
docker rm $containername
echo "-----------Installing $containername ------------"


echo $docker_cmd -v $(pwd):/work  -v $model2localpoint:$model2mountpoint  -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport  -e PASS1IMAGESIZE=$PASS1IMAGESIZE -e PASS2IMAGESIZE=$PASS2IMAGESIZE -e SPORT=$serverhostport $compocontainertag
sleep 1
$docker_cmd -v $(pwd):/work  -v $model2localpoint:$model2mountpoint  -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport  -e PASS1IMAGESIZE=$PASS1IMAGESIZE -e PASS2IMAGESIZE=$PASS2IMAGESIZE  -e MODELNAME=$modelname -e MODEL2NAME=$model2name  -e SPORT=$serverhostport $compocontainertag

