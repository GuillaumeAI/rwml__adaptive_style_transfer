source _env.sh

featuretag=feat-timelining-21040614
source $featuretag.env.sh
containername=$featuretag'__ast_model_cezanne_vo_165ik'

docker exec -it $containername bash
