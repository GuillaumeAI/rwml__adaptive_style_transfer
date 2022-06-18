source _env.sh


# Would make a copy pushed to private repo 


export modelname="$1"
#export containerbasename=ast_dbginko-v03_sone_
export containerbasename=$(getfnamefrommodel $modelname)
# The resolution of the two passes

export PASS1IMAGESIZE=512

# Auto Brightness Contrast Adjustments
#0 off, 1 on

export AUTOABC=1
if [ "$4" == "" ]; then export AUTOABC=0;fi


#chks="15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345 360 375 390 405"
chks="$3"
export startserverport=$2

export launcher_script=zeus-custom-cli-start-script-docker-dev-specific-checkpoint-singleone.210606.sh

export docker_mode="d"
export docker_run_args="--restart unless-stopped "



export serverhostport=$startserverport

for c in $chks ; do
	export	 checkpointno=$c


	#export checkpointno=345
	export containername=$containerbasename$checkpointno

	source $launcher_script \
		$modelname \
		$serverhostport \
		$PASS1IMAGESIZE \
       		$checkpointno \
					$AUTOABC
	
	serverhostport=$(expr $serverhostport + 1)

done


## MODELNAME APIPORT PASS1IMAGESIZE CHECKPOINT_NUM [--fg (debug)] "
#source __launch-docker-compo-doubletwo-v1-dev.sh $1 $2

