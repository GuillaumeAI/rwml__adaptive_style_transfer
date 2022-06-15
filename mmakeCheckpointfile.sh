#!/bin/bash

#########################################################
# Model Web API Checkpoint Server                       #
# This version should receive a checkpoint number       #
# as input to mount along with the modelname            #
# By Guillaume Descoteaux-Isabelle, 2021 (UQAC/NAD)     #
#########################################################

# 
### SEE IN __fn.sh > makecheckpointfile()




























source _env.sh
modelname=$1
checkpointno=$2
modelmountpath=$modelroot


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
echo "Working in  $modellocalpoint"
tmpmodelfilename=$(cd $modellocalpoint;ls *$mmeta)
replstring='_'$checkpointpad$mmeta
secondString=""
tmpbasename="${tmpmodelfilename/$replstring/$secondString}"

checkpointbasefilename=$tmpbasename
mcheckpointfilecontentline1='model_checkpoint_path: "'$checkpointbasefilename$mfilepresuffix$mfilesuffix'"'
mcheckpointfilecontentline2='all_model_checkpoint_paths: "'$checkpointbasefilename$mfilepresuffix$mfilesuffix'"'
astia_server_file_location='/tmp/astiatmp'
mkdir -p $astia_server_file_location

mcheckpointfilepath=$astia_server_file_location'/'$modelname'_checkpoint_'$checkpointno
mindexfile=$checkpointbasefilename$mfilepresuffix$mindex
mmetafile=$checkpointbasefilename$mfilepresuffix$mmeta
mdatafile=$checkpointbasefilename$mfilepresuffix$mdata

testing=1
if [ "$testing" == "1" ]; then

echo "-----------------------------------------------Tests: "
#echo "- tmpmodelfilename=$tmpmodelfilename"
#echo "- replstring=$replstring"
#echo "- checkpointbasefilename=$checkpointbasefilename"
#echo "- mcheckpointfilecontent=$mcheckpointfilecontent"
#echo "- remove : $replstring in $tmpmodelfilename and use to construct the checkpoint file"
#echo "-- it gives: $tmpbasename"
echo "-- So the checkpoint file content is >>"
echo "$mcheckpointfilecontentline1"
echo "$mcheckpointfilecontentline2"
echo "<<"
#echo "- checkpointbasefilename=$checkpointbasefilename"
#echo "- mfilepresuffix=$mfilepresuffix"
#echo "- mfilesuffix=$mfilesuffix"
echo "- mindexfile=$mindexfile"
echo "- mmetafile=$mmetafile"
echo "- mdatafile=$mdatafile"
fi
# Making the local checkpoint we will mount
echo "$mcheckpointfilecontentline1" > $mcheckpointfilepath
echo "$mcheckpointfilecontentline2" >> $mcheckpointfilepath
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
echo "-            Running  Guillaume's M.A. AI Model Server      -"
echo "- Model Name: $modelname"
echo "- Model Checkpoint: $checkpointno"

echo "-------------------------------------------------------------"
echo "see this file : __launch-docker-dev-specific-checkpoint.210430.sh"
echo "if you want to look how it is used"

echo "------------------------------------"
echo "-- File created :  cat $mcheckpointfilepath"
export MCHECKPOINTFILEPATH=$mcheckpointfilepath
echo "------------ or use : \$MCHECKPOINTFILEPATH"
