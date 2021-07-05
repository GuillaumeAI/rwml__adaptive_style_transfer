source _env.sh

# ARTIST : CHG Model name


export modelname="model_gia-ds-fpolsonwill_v02_210424_new-195ik"
export model2name="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-210ik"
export model3name="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-270ik"

#we use it for meta for now
#export checkpointno="195-210-270"


# The resolution of the two passes
#export PASS1IMAGESIZE=1328
#export PASS2IMAGESIZE=1024
#export PASS3IMAGESIZE=2048
export PASS1IMAGESIZE=800
export PASS2IMAGESIZE=1300
export PASS3IMAGESIZE=2100

export containername=ast_compo-fpw_v2_195_dbg-v01b_210-270


export serverhostport=9093

#export docker_mode="it"
export docker_mode="d"
#export docker_run_args="--rm "
export docker_run_args="--restart unless-stopped "



source __launch-docker-compo-three-v2-dev.sh $1 $2


