
# Compose 3 models together
# Ran by another script that preped all we need

export docker_cmd="docker run -$docker_mode $docker_run_args --name $containername "

if [ "$1" == "--it" ]; then #we will run it interactively
  docker_cmd="docker run -it --rm --name $containername "
fi


if [ $docker_mode = "d" ] ; then echo "Background infrastructure mode activated (will run in background until stopped or server rebooted)" ; fi
if [ $docker_mode = "it" ] ; then echo "Foreground infrastructure mode activated (require to keep the startup shell active)" ; fi


export callurl="$callprotocol://$hostdns:$serverhostport"

export modelmountpoint="$containermodelroot/$modelname/checkpoint_long"
export model2mountpoint="$containermodelroot/$model2name/checkpoint_long"
export model3mountpoint="$containermodelroot/$model3name/checkpoint_long"
export modellocalpoint="$modelmountpath/$modelname/checkpoint_long"
export model2localpoint="$modelmountpath/$model2name/checkpoint_long"
export model3localpoint="$modelmountpath/$model3name/checkpoint_long"

echo "------------------------------------------------------"
echo "- Running  Guillaume's M.A. AI                       -"
echo "- AST Compo Three v2-dev Model Server                -"
echo "- Model Name: $modelname"
echo "- Model2 Name: $model2name"
echo "- Model3 Name: $model3name"
echo "- AccessURL : $callurl"
echo "------------------------------------------------------"
#$docker_cmd -v $(pwd):/work -p 8000:9000 -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd
echo "----------Cleaning up $containername-------"
docker stop $containername
docker rm $containername
echo "-----------Installing $containername ------------"

#@a Save model metadata for further id of results
#@state We store by Port
metarootdir=/www
metabasepath=astia/info
metarelfilepath=$metabasepath/$serverhostport.json
mkdir -p $metarootdir/$metabasepath
metafile=$metarootdir/$metarelfilepath
getmetaurl="$callprotocol://$hostdns/$metarelfilepath"

echo "{ " >   $metafile
echo "\"modelname\":\"$modelname\"," >>  $metafile
echo "\"containername\":\"$containername\",">>    $metafile
echo "\"checkpointno\":\"$checkpointno\",">>    $metafile
echo "\"type\":\"compothree\",">>    $metafile
echo "\"callurl\":\"$callurl\",">>    $metafile
echo "\"PASS1IMAGESIZE\":\"$PASS1IMAGESIZE\"," >>    $metafile
echo "\"PASS2IMAGESIZE\":\"$PASS2IMAGESIZE\"," >>    $metafile
echo "\"getmetaurl\":\"$getmetaurl\"," >>    $metafile
echo "\"created\":\"$(date)\"" >>    $metafile
echo "}">>    $metafile

#@STCGoal Central registration of currently running services
export globallocationpath=/home/jgi/astiapreviz
cdir=$(pwd)
gtpath=$globallocationpath/svr/$HOSTNAME
mkdir -p $gtpath
(cp $metafile $gtpath && cd $gtpath && ls *json> list.txt)  &




execme="$docker_cmd -v $(pwd):/work  -v $model2localpoint:$model2mountpoint  -v $modellocalpoint:$modelmountpoint  -v $model3localpoint:$model3mountpoint -p $serverhostport:$serverport  -e PASS1IMAGESIZE=$PASS1IMAGESIZE -e PASS2IMAGESIZE=$PASS2IMAGESIZE -e PASS3IMAGESIZE=$PASS3IMAGESIZE -e MODELNAME=$modelname -e MODEL1NAME=$modelname -e MODEL2NAME=$model2name -e MODEL3NAME=$model3name  -e SPORT=$serverhostport $dkrun_mount_binroot $dkrun_mount_droxconf_config_args $compo3v2devcontainertag"

echo $execme
sleep 1
$execme

# Proxy
astlaunchsslproxy $containername $serverhostport

