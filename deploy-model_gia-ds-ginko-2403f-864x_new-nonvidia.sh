source _env.sh

## --@STCGoal Drawing Stylization Mount model checkpoint
m=model_gia-ds-dbginko-v03-210809-864x_new
m=model_gia-ds-ginko-2403f-864x_new
m=model_gia-ds-ginko-2403f-864x_new


all_chk="15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345 360 375 390 405 420 435 450 465 480 495 510 525 540 555 570"


export modelname="$m"

# The resolution of the two passes
export PASS1IMAGESIZE=2048
export startserverport=9980

chks="15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345 360 375 390 405"
chks="15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240"

chks="300 315 330 345 360 375 390 405 420 435 450 465 480 495 510 525 540 555 570"
chks="555 565 570 585"


#chks="15 30"


export serverhostport=$startserverport

for c in $chks ; do
	export	 checkpointno=$c


	#export checkpointno=345
	export containername=ginko2403_s1a_$checkpointno


	export docker_mode="d"

	export docker_run_args="--restart unless-stopped "


	source custom-cli-start-script-docker-dev-specific-checkpoint-singleone.210606.sh \
		$modelname \
		$serverhostport \
		$PASS1IMAGESIZE \
       		$checkpointno
	
	serverhostport=$(expr $serverhostport + 1)

done


## MODELNAME APIPORT PASS1IMAGESIZE CHECKPOINT_NUM [--fg (debug)] "
#source __launch-docker-compo-doubletwo-v1-dev.sh $1 $2


