source _env.sh

# ARTIST : CHG Model name
#export modelname="model_gia-ds-fpolsonwill_v02_210424_new-195ik"
#export model2name="model_gia-young-picasso-v05-2101082232_new-150ik"

#export modelname="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new"
#model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-90ik_
export modelname="model_gia-young-picasso-v03-201216_new-60ik"
#export model2name="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-270ik"
#export model3name="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-60ik"
# The resolution of the two passes
#export PASS1IMAGESIZE=1328
#export PASS2IMAGESIZE=1024
#export PASS3IMAGESIZE=2048
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

