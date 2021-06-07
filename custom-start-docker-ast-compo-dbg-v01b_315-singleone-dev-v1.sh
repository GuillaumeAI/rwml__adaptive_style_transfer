source _env.sh

# ARTIST : CHG Model name


export modelname="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new"

# The resolution of the two passes

export PASS1IMAGESIZE=2100
export checkpointno=315
export containername=compo_ast_dbg_v01b_s1_315


export serverhostport=9037


export docker_mode="d"

export docker_run_args="--restart unless-stopped "


source custom-cli-start-script-docker-dev-specific-checkpoint-singleone.210606.sh $modelname $PASS1IMAGESIZE $serverhostport $checkpointno

## MODELNAME APIPORT PASS1IMAGESIZE CHECKPOINT_NUM [--fg (debug)] "
#source __launch-docker-compo-doubletwo-v1-dev.sh $1 $2


