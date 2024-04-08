ctlid=2403300347
dockertag=guillaumeai/ast:base-2403

containername=astbase2403
dkhostname=$containername

# PORT
dkport=9861:7860

model_foldername=model_cezanne
#model_foldername=model_gauguin
xmount=/var/lib/ast/model/$model_foldername:/data/styleCheckpoint/$model_foldername
xmount2=/a/src/ast:/ast

#dkcommand=bash #command to execute (default is the one in the dockerfile)

#dkextra=" -v \$dworoot/x:/x -p 2288:2288 "

#dkmounthome=true


##########################
############# RUN MODE
#dkrunmode="bg" #default fg
#dkrestart="--restart" #default
#dkrestarttype="unless-stopped" #default


#########################################
################## VOLUMES
#dkvolume="myvolname220413:/app" #create or use existing one
#dkvolume="$containername:/app" #create with containername name



#dkecho=true #just echo the docker run


# Use TZ
#DK_TZ=1



#####################################
#Build related
#
##chg back to that user
#dkchguser=vscode

######################## HOOKS BASH
### IF THEY EXIST, THEY are Executed, you can change their names

dkbuildprebuildscript=dkbuildprebuildscript.sh
dkbuildbuildsuccessscript=dkbuildbuildsuccessscript.sh
dkbuildfailedscript=dkbuildfailedscript.sh
dkbuildpostbuildscript=dkbuildpostbuildscript.sh

###########################################
# Unset deprecated
unset DOCKER_BUILDKIT

