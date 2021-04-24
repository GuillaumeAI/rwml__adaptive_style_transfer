#!/bin/bash

# script.sh MODEL_NAME 

source _env.sh


export modelname="$1"
export containername="$2"
export serverhostport=$3


source __launch-docker.sh

