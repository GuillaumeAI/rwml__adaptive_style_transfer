
containertag="guillaumeai/ast:runwayml_picasso_2103180139"
modelmountpath="/mnt/c/model/models"
modelname="model_giapicallo_v04__201221-090ik"
containermodelroot="/data/styleCheckpoint"


serverport=9000
serverhostport=9000
docker_cmd="docker run -it --rm "
run_cmd="bash"

modelmountpoint="$containermodelroot/$modelname/checkpoint_long"
modellocalpoint="$modelmountpath/$modelname/checkpoint_long"


#$docker_cmd -v $(pwd):/work -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd
## added the mount point to 8000 as the python server.py
### When imported in RunwayML, it might not be required as the Runway probably wrap it differently
echo "run : python server.py # When entering Docker"
$docker_cmd -v $(pwd):/work -p 8000:8000 -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd

