

source _env.sh

export modelname="$1"
export subportnum=$2
export serverhostport="900$2"


modelmountpoint="$containermodelroot/$modelname/checkpoint_long"
modellocalpoint="$modelmountpath/$modelname/checkpoint_long"


#$docker_cmd -v $(pwd):/work -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd
## added the mount point to 8000 as the python server.py
### When imported in RunwayML, it might not be required as the Runway probably wrap it differently
echo "run : python server.py # When entering Docker"
#$docker_cmd -v $(pwd):/work -p 8000:9000 -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd
echo "Model localpoint : $modellocalpoint"
echo "PortMap:   $serverhostport:$serverport"

$docker_cmd -v $(pwd):/work  -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag 

