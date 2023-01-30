
. .env
# Ran by another script that preped all we need

export docker_cmd="docker run -$docker_mode $docker_run_args --name $containername "
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
echo "----------Cleaning up-------"
docker stop $containername
docker rm $containername
echo "-----------Installing $containername ------------"
#@a Save model metadata for further id of results
#@state We store by Port
metarootdir=/www
metabasepath=astia/info
metarelfilepath=$metabasepath/$serverhostport.json
sudo mkdir -m 777 -p $metarootdir/$metabasepath
metafile=$metarootdir/$metarelfilepath
getmetaurl="$callprotocol://$hostdns/$metarelfilepath"

fname=$(getfnamefrommodel $modelname)
sudo chmod 777  $metafile &> /dev/null


echo "{ " >   $metafile
echo "\"modelname\":\"$modelname\"," >>  $metafile
echo "\"fname\":\"$fname\"," >>  $metafile
echo "\"containername\":\"$containername\",">>    $metafile
echo "\"containertag\":\"$containertag\",">>    $metafile
echo "\"checkpointno\":\"$checkpointno\",">>    $metafile
echo "\"svrtype\":\"s1\",">>    $metafile
echo "\"mtype\":\"ast\",">>    $metafile
echo "\"callurl\":\"$callurl\",">>    $metafile
echo "\"PASS1IMAGESIZE\":\"-1\"," >>    $metafile
echo "\"PASS2IMAGESIZE\":\"-1\"," >>    $metafile
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


echo $docker_cmd -v $(pwd):/work  -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport -e SPORT=$serverhostport $containertag
sleep 2
$docker_cmd -v $(pwd):/work  -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport -e SPORT=$serverhostport $containertag

