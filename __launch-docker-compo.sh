

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
docker stop $containername 2> /dev/null
docker rm $containername 2> /dev/null
echo "-----------Installing $containername ------------"

#@a Save model metadata for further id of results
#@state We store by Port
metarootdir=/www
metabasepath=astia/info
metarelfilepath=$metabasepath/$serverhostport.json
mkdir -p $metarootdir/$metabasepath
metafile=$metarootdir/$metarelfilepath
getmetaurl="$callprotocol://$hostdns/$metarelfilepath"



fname=$(getfnamefrommodel $modelname-$model2name)

echo "{ " >   $metafile
echo "\"modelname\":\"$modelname;$model2name\"," >>  $metafile
echo "\"fname\":\"$fname\"," >>  $metafile
echo "\"containername\":\"$containername\",">>    $metafile
echo "\"containertag\":\"$compo2dtv1devcontainertag\",">>    $metafile
echo "\"checkpointno\":\"$checkpointno\",">>    $metafile
echo "\"svrtype\":\"c2\",">>    $metafile
echo "\"mtype\":\"ast\",">>    $metafile
echo "\"callurl\":\"$callurl\",">>    $metafile
echo "\"PASS1IMAGESIZE\":\"$PASS1IMAGESIZE\"," >>    $metafile
echo "\"PASS2IMAGESIZE\":\"$PASS2IMAGESIZE\"," >>    $metafile
echo "\"PASS3IMAGESIZE\":\"-1\"," >>    $metafile
#echo "\"getmetaurl\":\"$getmetaurl\"," >>    $metafile
echo "\"created\":\"$(date)\"" >>    $metafile
echo "}">>    $metafile


#@STCGoal Central registration of currently running services
#export globallocationpath=/home/jgi/astiapreviz
cdir=$(pwd)
gtpath=$globallocationpath/svr/$HOSTNAME
mkdir -p $gtpath
(cp $metafile $gtpath && cd $gtpath && ls *json> list.txt)  &


#echo $docker_cmd -v $(pwd):/work  -v $model2localpoint:$model2mountpoint  -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport  -e PASS1IMAGESIZE=$PASS1IMAGESIZE -e PASS2IMAGESIZE=$PASS2IMAGESIZE -e SPORT=$serverhostport $compocontainertag
sleep 1
torun="$docker_cmd -v $(pwd):/work  -v $model2localpoint:$model2mountpoint  -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport  -e PASS1IMAGESIZE=$PASS1IMAGESIZE -e PASS2IMAGESIZE=$PASS2IMAGESIZE  -e MODELNAME=$modelname -e MODEL2NAME=$model2name  -e SPORT=$serverhostport $compocontainertag"
echo $torun
$torun
