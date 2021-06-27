source _env.sh

# ARTIST : CHG Model name



export modelname="model_gia-young-picasso-v03-201216_new-60ik"

export PASS1IMAGESIZE=700
export PASS2IMAGESIZE=2000
#export PASS3IMAGESIZE=1538

export containername=compo_ast_pica_v03_dt60


export serverhostport=9091

#export docker_mode="it"
export docker_mode="d"
#export docker_run_args="--rm "
export docker_run_args="--restart unless-stopped "



source __launch-docker-compo-doubletwo-v1-dev.sh $1 $2


