source _env.sh

# ARTIST : CHG Model name


export modelname="model_gia-ds-dbginko-v03-210809-864x_new"
export containerbasename=ast_dbginko-v03_sone_
export tmpfname=$(getfnamefrommodel $modelname)
# The resolution of the two passes

export PASS1IMAGESIZE=512

export startserverport=9071

export launcher_script=custom-cli-start-script-docker-dev-specific-checkpoint-singleone.210606.sh

#chks="15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345 360 375 390 405"
#chks="300 315 330 345 360 375 390 405 420 435 450 465 480 495 510 525 540 555"
chks="465 480"

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
       		$checkpointno
	
	serverhostport=$(expr $serverhostport + 1)

done


## MODELNAME APIPORT PASS1IMAGESIZE CHECKPOINT_NUM [--fg (debug)] "
#source __launch-docker-compo-doubletwo-v1-dev.sh $1 $2


