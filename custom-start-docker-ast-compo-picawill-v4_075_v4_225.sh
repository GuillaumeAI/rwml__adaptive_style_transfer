source _env.sh

# ARTIST : CHG Model name

export modelname="model_gia-young-picasso-v04-2012211928_new-75ik"
export model2name="model_gia-young-picasso-v04-2012211928_new-225ik"
# The resolution of the two passes
export PASS1IMAGESIZE=300
export PASS2IMAGESIZE=1920

export containername=compo_ast_picawill_v4_075_v4_225


export serverhostport=9054

#export docker_mode="it"
export docker_mode="d"
#export docker_run_args="--rm "
export docker_run_args="--restart unless-stopped "



source __launch-docker-compo.sh
