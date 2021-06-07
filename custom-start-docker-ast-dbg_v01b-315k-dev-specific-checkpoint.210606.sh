#!/bin/bash

#source _env.sh

# ARTIST : CHG Model name



export modelname="model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-315ik"
export checkpointno=315
export serverhostport=36

############################## BECAUSE WE ARE DEVELOPPING
export scriptfn=custom-cli-start-script-docker-dev-specific-checkpoint.210430.sh


source $scriptfn "$modelname" $serverhostport $checkpointno

