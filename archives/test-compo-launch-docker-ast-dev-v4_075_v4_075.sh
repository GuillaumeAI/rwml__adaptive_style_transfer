source _env.sh

# ARTIST : CHG Model name


export modelname="model_gia-young-picasso-v04-2012211928_new-75ik"
export model2name="model_gia-young-picasso-v04-2012211928_new-75ikb"
# The resolution of the two passes
export PASS1IMAGESIZE=300
export PASS2IMAGESIZE=2048

export containername=compo_ast_picawill_v4_075_v4_075


export serverhostport=9092



export docker_mode="it"
export docker_run_args="--rm "




#source __launch-docker.sh
source __launch-docker-test-compo.sh
