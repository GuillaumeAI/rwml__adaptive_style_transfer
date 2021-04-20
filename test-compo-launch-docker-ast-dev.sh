

source _env.sh

# ARTIST : CHG Model name



export modelname="model_gia-young-picasso-v05-2101082232_new-150ik"
export model2name="model_gia-young-picasso-v03-201216_new-120ik"
export PASS1IMAGESIZE=1024
export PASS2IMAGESIZE=2048

export containername=compo_ast_picawill_v5_150_v3_120


export serverhostport=9090

export docker_mode="it"
export docker_run_args="--rm "


export containerns="guillaumeai"
export containerreponame="server"
export containerrepotag="ast"
# Testing the new version
export containerrepotag="ast-210420-compo"
export containerrepo="$containerns/$containerreponame"
#export containertag="guillaumeai/server:ast"
export containertag="$containerrepo:$containerrepotag"

#source __launch-docker.sh
source __launch-docker-test-compo.sh
