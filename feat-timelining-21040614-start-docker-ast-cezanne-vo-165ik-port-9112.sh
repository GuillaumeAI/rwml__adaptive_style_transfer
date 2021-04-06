

featuretag=feat-timelining-21040614
source $featuretag.env.sh

# ARTIST : CHG Model name


export modelname="model_gia-ds-cezanne-vo_new-165ik"

export containername=$featuretag'__ast_model_cezanne_vo_165ik'


export serverhostport=9112
echo "Serverhostport is : $serverhostport"
sleep 1


source __launch-docker.sh

