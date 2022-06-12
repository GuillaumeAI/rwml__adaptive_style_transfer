source _env.sh

# ARTIST : CHG Model name

export modelname="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-60ik"
export model2name="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-120ik"

# The resolution of the two passes
export PASS1IMAGESIZE=512
export PASS2IMAGESIZE=2060

export containername=compo_ast_dbg-v01b_60_120


export serverhostport=9097

#export docker_mode="it"
export docker_mode="d"
#export docker_run_args="--rm "
export docker_run_args="--restart unless-stopped "



source __launch-docker-compo.sh $1 $2

