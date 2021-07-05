source _env.sh

# ARTIST : CHG Model name


export modelname="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-150ik"

# The resolution of the two passes

export PASS1IMAGESIZE=576
export PASS2IMAGESIZE=2100
#export PASS3IMAGESIZE=1538

export containername=compo_ast_dbg_v01b_dt150


export serverhostport=9092

#export docker_mode="it"
export docker_mode="d"
#export docker_run_args="--rm "
export docker_run_args="--restart unless-stopped "



source __launch-docker-compo-doubletwo-v1-dev.sh $1 $2


