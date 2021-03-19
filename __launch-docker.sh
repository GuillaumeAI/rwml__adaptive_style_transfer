

# Ran by another script that preped all we need



export modelmountpoint="$containermodelroot/$modelname/checkpoint_long"
export modellocalpoint="$modelmountpath/$modelname/checkpoint_long"


echo "run : python server.py # When entering Docker"
#$docker_cmd -v $(pwd):/work -p 8000:9000 -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd
$docker_cmd -v $(pwd):/work  -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag

