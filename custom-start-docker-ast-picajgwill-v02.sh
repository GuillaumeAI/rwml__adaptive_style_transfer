
source _env.sh


export modelname="model_gia-young-picasso-v02-201210-240ik"
export modelname="model_gia-young-picasso-201210_new-135000"




export serverhostport=9000






export modelmountpoint="$containermodelroot/$modelname/checkpoint_long"
export modellocalpoint="$modelmountpath/$modelname/checkpoint_long"


#$docker_cmd -v $(pwd):/work -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd
## added the mount point to 8000 as the python server.py
### When imported in RunwayML, it might not be required as the Runway probably wrap it differently
echo "run : python server.py # When entering Docker"
#$docker_cmd -v $(pwd):/work -p 8000:9000 -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd
$docker_cmd -v $(pwd):/work  -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag 


