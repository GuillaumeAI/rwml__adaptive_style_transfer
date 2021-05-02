#!/bin/bash

#source _env.sh

# ARTIST : CHG Model name



export modelname="model_gia-ds-fpolsonwill_v02_210424_new"
export checkpointno=195
export serverhostport=9091

############################## BECAUSE WE ARE DEVELOPPING
export scriptfn=custom-cli-start-script-docker-dev-specific-checkpoint.210430.sh


source $scriptfn "$modelname" $serverhostport $checkpointno

