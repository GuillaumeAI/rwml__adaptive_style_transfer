export chkps="60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300 315 330 345 360 375 390 405"
export chkps=60
export mname="model_gia-ds-fpolsonwill_v02_210424_new"
export apiport=60
export autoabc=25
export imgpass1=2048

. zeus-custom-cli-start-script-docker-dev-specific-checkpoint-singleone.210606.sh $mname $apiport $imgpass1 $chkps $autoabc
