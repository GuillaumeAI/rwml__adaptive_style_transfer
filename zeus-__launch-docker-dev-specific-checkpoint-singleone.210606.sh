#!/bin/bash

#########################################################
# Model Web API Checkpoint Server DoubleTwo             #
# This version should receive a checkpoint number       #
# as input to mount along with the modelname            #
# By Guillaume Descoteaux-Isabelle, 2021 (UQAC/NAD)     #
#########################################################

# 
if [ "$1" == "--fg" ]; then 
	docker_mode="it"
	docker_run_args="--rm"
fi
export docker_cmd="docker run -$docker_mode $docker_run_args --name $containername "
if [ $docker_mode = "d" ] ; then echo "Background infrastructure mode activated (will run in background until stopped or server rebooted)" ; fi
if [ $docker_mode = "it" ] ; then echo "Foreground infrastructure mode activated (require to keep the startup shell active)" ; fi


export callurl="$callprotocol://$hostdns:$serverhostport/stylize"
# local path and container mount path : modelmountpoint modellocalpoint
export modelmountpoint="$containermodelroot/$modelname/checkpoint_long"
export modellocalpoint="$modelmountpath/$modelname/checkpoint_long"

####@TODO MAke the 3 model file and checkpoint specific file
# $modelmountpath  = /a/model/models/$modelname/checkpoint_long
# $modellocalpoint # The root where we will mount the files
# Files :
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
mkdir -p $astia_server_file_location
mcheckpointfilepath=$astia_server_file_location'/'$modelname'_checkpoint_'$checkpointno
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
echo "- Running  Guillaume's M.A. AI Model Server SingleOne     -"
echo "- Model: $modelname"
echo "- Model Checkpoint: $checkpointno"
echo "- AccessURL : $callurl"
echo "-------------------------------------------------------------"

#echo "Exting because we are testing" ;exit 1

#$docker_cmd -v $(pwd):/work -p 8000:9000 -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd
echo "----------Cleaning up $containername-------"
docker stop $containername  &> /dev/null
docker rm $containername  &> /dev/null && echo "--Cleanup done" || echo "-- nothing to cleanup" 
echo "-----------Installing $containername ------------"


#echo "Exting because we are testing" ;exit 1


execme="$docker_cmd -v $(pwd):/work  \
	-v /a/bin:/a/bin \
	 -e PASS1IMAGESIZE=$PASS1IMAGESIZE \
	 -e MODELNAME=$modelname \
	 -e MODEL1NAME=$modelname  \
	-v $modellocalpointmeta:$modelmountpointmeta \
	-v $modellocalpointindex:$modelmountpointindex \
	-v $modellocalpointdata:$modelmountpointdata \
	-v $mcheckpointfilepath:$modelmountpointckfile \
	-p $serverhostport:$serverport \
	 -e SPORT=$serverhostport $singleonev1devcontainertag"

#@a Save model metadata for further id of results
#@state We store by Port

metafilename=$serverhostport.json
mkdir -p $metahttpdocastinfopath
metafile=$metahttpdocastinfopath/$metafilename
if [ "$hostdns" == "" ] ; then export hostdns=localhost;fi
getmetaurl="$callprotocol://$hostdns/$metafilename"

fname=$(getfnamefrommodel $modelname)

#ZEUS
export zeustag="$zeussingleonev1devcontainertag--$containername"
echo "ZeusTag=$zeustag"

echo "{ " >   $metafile
echo "\"modelname\":\"$modelname\"," >>  $metafile
echo "\"fname\":\"$fname\"," >>  $metafile
echo "\"containername\":\"$containername\",">>    $metafile
echo "\"containertag\":\"$compo3v2devcontainertag\",">>    $metafile
echo "\"checkpointno\":\"$checkpointno\",">>    $metafile
echo "\"svrtype\":\"s1\",">>    $metafile
echo "\"mtype\":\"ast\",">>    $metafile
echo "\"type\":\"singleone\",">>    $metafile
echo "\"callurl\":\"$callurl\",">>    $metafile
echo "\"PASS1IMAGESIZE\":\"$PASS1IMAGESIZE\"," >>    $metafile 
echo "\"getmetaurl\":\"$getmetaurl\"," >>    $metafile
echo "\"created\":\"$(date)\"" >>    $metafile
echo "}">>    $metafile

#@STCGoal Central registration of currently running services
if [ "$metaglobalregistryfeature" == "1" ] ; then
	        #moved _env.sh export globallocationpath=/home/jgi/astiapreviz
	        cdir=$(pwd)
	        gtpath=$globallocationpath/svr/$HOSTNAME
	        mkdir -p $gtpath
	        (cp $metafile $gtpath && cd $gtpath && ls *json> list.txt)  &
fi

echo "$execme"
echo "----------------OLD Exec as ref ---------------"
#sleep 1
#echo "$serverhostport"

#$execme
cdir="$(pwd)"
tdir="$modellocalpoint"
cd $tdir
#ls 
mkdir -p build
cp -f $mcheckpointfilepath build/checkpoint
#pwd
#ls build 
#cat build/checkpoint
#sleep 2
echo "#---------ZEUS DESIGN 220611"  > Dockerfile
echo "#---This in the Dockerfile" >> Dockerfile
echo "#-----#singleonev1devcontainertag" >> Dockerfile
echo "#-----$singleonev1devcontainertag" >> Dockerfile
echo "FROM $singleonev1devcontainertag" >> Dockerfile
echo "#MODEL1NAME=$modelname" >> Dockerfile
echo "#mkdir \$modelmountpoint" >> Dockerfile
echo "WORKDIR $modelmountpoint" >> Dockerfile
echo "COPY $mmetafile ." >> Dockerfile
echo "COPY $mindexfile ." >> Dockerfile
echo "COPY $mdatafile ." >> Dockerfile
echo "COPY ./build/checkpoint ." >> Dockerfile
echo "#Back to /model to run the server" >> Dockerfile
echo "WORKDIR /model" >> Dockerfile
cat Dockerfile
#sleep 1
docker build -t  $zeustag .
cd $cdir

execme="$docker_cmd -v $(pwd):/work 
	 -e PASS1IMAGESIZE=$PASS1IMAGESIZE \
	 -e MODELNAME=$modelname \
	 -e MODEL1NAME=$modelname  -p $serverhostport:$serverport \
	 -e SPORT=$serverhostport $zeustag"

echo "----------------NEW Docker run ---------------"
echo "$execme"
pwd

$execme

echo "-------------------------------------"
echo "1. Might want to push :"
echo "docker push $zeustag"
echo "---"
echo "2. Might want to Run it..."
echo "3. Delete the container:"
echo "   docker rm --force --volumes $containername"
echo "4. Delete the image:"
echo "   docker rmi $zeustag"
