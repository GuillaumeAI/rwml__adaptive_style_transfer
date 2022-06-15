source _env.sh

# ARTIST : CHG Model name


export modelname="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new"

# The resolution of the two passes

export PASS1IMAGESIZE=512

export startserverport=9019

chks="285"

export serverhostport=$startserverport

for c in $chks ; do
	export	 checkpointno=$c


	#export checkpointno=345
	export containername=compo_ast_dbg_v01b_s1a_$checkpointno


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


