#!/bin/bash

source _env.sh
#docker run -it --rm -p 8000:9000 -v /a:/a $containertag bash
modelname="model_gia-young-picasso-v03-201216_new-165ik"

nvidia-docker run -it -v /a/model/models/$modelname:/data/styleCheckpoint/$modelname -v $(pwd):/work -p 8000:9000 -e SPORT=9000 -v /a/model/models:/model/models  $containertag bash
