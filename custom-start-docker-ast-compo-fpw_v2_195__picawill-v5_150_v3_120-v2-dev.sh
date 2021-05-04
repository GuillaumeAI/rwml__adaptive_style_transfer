source _env.sh

# ARTIST : CHG Model name

export modelname="model_gia-ds-fpolsonwill_v02_210424_new-195ik"
export model2name="model_gia-young-picasso-v05-2101082232_new-150ik"
export model3name="model_gia-young-picasso-v03-201216_new-120ik"
# The resolution of the two passes
#export PASS1IMAGESIZE=1328
#export PASS2IMAGESIZE=1024
#export PASS3IMAGESIZE=2048
export PASS1IMAGESIZE=640
export PASS2IMAGESIZE=768
export PASS3IMAGESIZE=1538

export containername=compo_ast_pik_v5_150_v3_120_fpw_v2_195_v2_dev


export serverhostport=9098

#export docker_mode="it"
export docker_mode="d"
#export docker_run_args="--rm "
export docker_run_args="--restart unless-stopped "



source __launch-docker-compo-three-v2-dev.sh
