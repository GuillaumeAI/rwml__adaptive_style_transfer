source _env.sh

# ARTIST : CHG Model name

export modelname="model_gia-young-picasso-v05-2101082232_new-195ik"
export model2name="model_gia-young-picasso-v03-201216_new-180ik"
# The resolution of the two passes
export PASS1IMAGESIZE=1024
export PASS2IMAGESIZE=2048

export containername=compo_ast_picawill_v5_195_v3_180


export serverhostport=9053

#export docker_mode="it"
export docker_mode="d"
#export docker_run_args="--rm "
export docker_run_args="--restart unless-stopped "



source __launch-docker-compo.sh
