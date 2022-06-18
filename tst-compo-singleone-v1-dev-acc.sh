source _env.sh

# ARTIST : CHG Model name


#export modelname="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new"
export modelname="model_gia-ds-dbginko-v03-210809-864x_new-435ik"

# The resolution of the two passes

export PASS1IMAGESIZE=512

export startserverport=9018

export chks="435"
export autoabc=1

export serverhostport=$startserverport

for c in $chks ; do
	export	 checkpointno=$c



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



