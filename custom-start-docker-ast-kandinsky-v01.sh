


# ARTIST : CHG Model name

modelname="model_gia-ds-wassily_kandinsky_v1_210310_new-210ik"



# ARTIST : Probably dont change anything bellow 

## Environment path related
modelmountpath="/mnt/c/model/models"


## Container related
containermodelroot="/data/styleCheckpoint"


# Infrastructure related
containertag="guillaumeai/ast:runwayml_picasso_2103180139"

serverport=8000
serverhostport=9000
docker_cmd="docker run -it --rm "
run_cmd="bash"




source _env.sh


modelmountpoint="$containermodelroot/$modelname/checkpoint_long"
modellocalpoint="$modelmountpath/$modelname/checkpoint_long"


#$docker_cmd -v $(pwd):/work -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd
## added the mount point to 8000 as the python server.py
### When imported in RunwayML, it might not be required as the Runway probably wrap it differently
echo "run : python server.py # When entering Docker"
#$docker_cmd -v $(pwd):/work -p 8000:9000 -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd
$docker_cmd -v $(pwd):/work  -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd

