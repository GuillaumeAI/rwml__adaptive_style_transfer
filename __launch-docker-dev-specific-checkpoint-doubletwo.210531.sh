#!/bin/bash

#########################################################
# Model Web API Checkpoint Server DoubleTwo             #
# This version should receive a checkpoint number       #
# as input to mount along with the modelname            #
# By Guillaume Descoteaux-Isabelle, 2021 (UQAC/NAD)     #
#########################################################

# 
#. _env.sh

if [ "$1" == "--fg" ]; then 
	docker_mode="it"
	docker_run_args="--rm"
fi
export docker_cmd="docker run -$docker_mode $docker_run_args --name $containername "
#export proxycontainername=$containername$sslcontainersuffix
#export docker_cmd_proxy="docker run -$docker_mode $docker_run_args --name $proxycontainername "
if [ $docker_mode = "d" ] ; then echo "Background infrastructure mode activated (will run in background until stopped or server rebooted)" ; fi
if [ $docker_mode = "it" ] ; then echo "Foreground infrastructure mode activated (require to keep the startup shell active)" ; fi

echo "----------Cleaning up $containername-------"
docker stop $containername  &> /dev/null
docker rm $containername  &> /dev/null && echo "--Cleanup done" || echo "-- nothing to cleanup"
echo "-----------Installing $containername ------------"
echo "-----Was it stopped and worked debugging??"

sleep 3
export callurl="$callprotocol://$hostdns:$serverhostport/stylize"
# local path and container mount path : modelmountpoint modellocalpoint
export modelmountpoint="$containermodelroot/$modelname/checkpoint_long"
export modellocalpoint="$modelmountpath/$modelname/checkpoint_long"

####@TODO MAke the 3 model file and checkpoint specific file
# $modelmountpath  = /a/model/models/$modelname/checkpoint_long
# $modellocalpoint # The root where we will mount the files
#@TODO Migrate the whole thing to function
#makecheckpointfile


# Files :
# .ckpt-195000.index .ckpt-195000.meta .data-00000-of-00001 model_gia-ds-fpolsonwill_v02_210424_new_195000. checkpoint
# 3 files
checkpointpad=$checkpointno'000'
mindex='.ckpt-'$checkpointpad'.index'
mmeta='.ckpt-'$checkpointpad'.meta'
#.ckpt-195000.data-00000-of-00001
mdata='.ckpt-'$checkpointpad'.data-00000-of-00001'
mfilesuffix='.ckpt-'$checkpointpad
mfilepresuffix='_'$checkpointpad

# Content of the ./checkpoint file
#>>model_checkpoint_path: "model_gia-ds-fpolsonwill_v02_210424_new_195000.ckpt-195000"
#>>all_model_checkpoint_paths: "model_gia-ds-fpolsonwill_v02_210424_new_195000.ckpt-195000"
tmpmodelfilename=$(cd $modellocalpoint;ls *$mmeta)
replstring='_'$checkpointpad$mmeta
secondString=""
tmpbasename="${tmpmodelfilename/$replstring/$secondString}"

checkpointbasefilename=$tmpbasename
# mcheckpointfilecontentline1='model_checkpoint_path: "'$checkpointbasefilename$mfilepresuffix$mfilesuffix'"'
# mcheckpointfilecontentline2='all_model_checkpoint_paths: "'$checkpointbasefilename$mfilepresuffix$mfilesuffix'"'
astia_server_file_location='/tmp/astia'
mkdir -p -m 777 $astia_server_file_location
mcheckpointfilepath=$astia_server_file_location'/'$modelname'_checkpoint_'$checkpointno
#sudo rmdir $astia_server_file_location/* &> /dev/null

mindexfile=$checkpointbasefilename$mfilepresuffix$mindex
mmetafile=$checkpointbasefilename$mfilepresuffix$mmeta
mdatafile=$checkpointbasefilename$mfilepresuffix$mdata

testing=0
if [ "$testing" == "1" ]; then

	echo "-----------------------------------------------Tests: "
	#echo "- tmpmodelfilename=$tmpmodelfilename"
	#echo "- replstring=$replstring"
	#echo "- checkpointbasefilename=$checkpointbasefilename"
	#echo "- mcheckpointfilecontent=$mcheckpointfilecontent"
	#echo "- remove : $replstring in $tmpmodelfilename and use to construct the checkpoint file"
	#echo "-- it gives: $tmpbasename"

	echo "<<"
	#echo "- checkpointbasefilename=$checkpointbasefilename"
	#echo "- mfilepresuffix=$mfilepresuffix"
	#echo "- mfilesuffix=$mfilesuffix"
	echo "- mindexfile=$mindexfile"
	echo "- mmetafile=$mmetafile"
	echo "- mdatafile=$mdatafile"
fi
# Making the local checkpoint we will mount
#echo "$mcheckpointfilecontentline1" > $mcheckpointfilepath
#echo "$mcheckpointfilecontentline2" >> $mcheckpointfilepath
makecheckpointfile $modelname $checkpointno
export mcheckpointfilepath="$MCHECKPOINTFILEPATH"

# Making path to mount from local to the docker host foreach of the 3 files
##modelmountpoint modellocalpoint
export modelmountpointmeta=$modelmountpoint/$mmetafile
export modelmountpointindex=$modelmountpoint/$mindexfile
export modelmountpointdata=$modelmountpoint/$mdatafile
export modelmountpointckfile=$modelmountpoint/checkpoint
export modellocalpointmeta=$modellocalpoint/$mmetafile
export modellocalpointindex=$modellocalpoint/$mindexfile
export modellocalpointdata=$modellocalpoint/$mdatafile

#echo "Exting because we are testing" ;exit 1

#############
echo "-------------------------------------------------------------"
echo "- Running  Guillaume's M.A. AI Model Server BoubleTwo     -"
echo "- Model: $modelname"
echo "- Model Checkpoint: $checkpointno"
echo "- AccessURL : $callurl"
echo "-------------------------------------------------------------"

#echo "Exting because we are testing" ;exit 1

#$docker_cmd -v $(pwd):/work -p 8000:9000 -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd
echo -n "----------Cleaning up $containername ------- "
docker stop $containername 
#&> /dev/null
docker rm $containername  
#&> /dev/null && echo "--Cleanup done" || echo "-- nothing to cleanup" 
echo " "

echo "-----------Installing $containername ------------"
sleep 1

#echo "Exting because we are testing" ;exit 1


execme="$docker_cmd -v $(pwd):/work  \
	-v /a/bin:/a/bin \
	 -e PASS1IMAGESIZE=$PASS1IMAGESIZE \
	 -e PASS2IMAGESIZE=$PASS2IMAGESIZE  \
	 -e MODELNAME=$modelname \
	 -e MODEL1NAME=$modelname  \
	-v $modellocalpointmeta:$modelmountpointmeta \
	-v $modellocalpointindex:$modelmountpointindex \
	-v $modellocalpointdata:$modelmountpointdata \
	-v $mcheckpointfilepath:$modelmountpointckfile \
	-p $serverhostport:$serverport \
	 -e SPORT=$serverhostport $compo2dtv1devcontainertag"

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
echo "\"type\":\"doubletwo\",">>    $metafile
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


echo "$execme"
sleep 1
#echo "$serverhostport"

$execme




if [ "$LAUNCHPROXY" != "" ] ; then astlaunchsslproxy $containername $serverhostport 
	else
		echo "Proxy launch skipped ( export LAUNCHPROXY=TRUE ) to bypass and launch"
fi
#$sport



