source _env.sh

# ARTIST : CHG Model name

export modelname="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-90ik_"
export model2name="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-90ik"
export model3name="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-60ik"
# The resolution of the two passes
#export PASS1IMAGESIZE=1328
#export PASS2IMAGESIZE=1024
#export PASS3IMAGESIZE=2048
export PASS1IMAGESIZE=640
export PASS2IMAGESIZE=768
export PASS3IMAGESIZE=1538

export containername=compo_ast_dbg_v01b_90_90_60_dev


export serverhostport=9099

#export docker_mode="it"
export docker_mode="d"
#export docker_run_args="--rm "
export docker_run_args="--restart unless-stopped "



source __launch-docker-compo-three-v2-dev.sh $1 $2


