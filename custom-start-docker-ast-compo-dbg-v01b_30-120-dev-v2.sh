source _env.sh

# ARTIST : CHG Model name

export modelname="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-30ik"
export model2name="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-120ik"

# The resolution of the two passes

export PASS1IMAGESIZE=640
export PASS2IMAGESIZE=1400
#export PASS3IMAGESIZE=1538

export containername=compo_ast_dbg_v01b_30_120_dev


export serverhostport=9095

#export docker_mode="it"
export docker_mode="d"
#export docker_run_args="--rm "
export docker_run_args="--restart unless-stopped "



source __launch-docker-compo-two-v2-dev.sh $1 $2


