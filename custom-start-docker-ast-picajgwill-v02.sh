
source _env.sh

# ARTIST : CHG Model name

 ## Override of _env for custem

modelname="model_gia-ds-wassily_kandinsky_v1_210310_new-210ik"
modelname="model_gia-young-picasso-v02-201210-240ik"



# ARTIST : Probably dont change anything bellow 


serverport=8000
serverhostport=9002
docker_cmd="docker run -it --rm "
run_cmd="bash"





modelmountpoint="$containermodelroot/$modelname/checkpoint_long"
modellocalpoint="$modelmountpath/$modelname/checkpoint_long"


#$docker_cmd -v $(pwd):/work -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd
## added the mount point to 8000 as the python server.py
### When imported in RunwayML, it might not be required as the Runway probably wrap it differently
echo "run : python server.py # When entering Docker"
#$docker_cmd -v $(pwd):/work -p 8000:9000 -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd
$docker_cmd -v $(pwd):/work  -v $modellocalpoint:$modelmountpoint -p $serverhostport:$serverport $containertag $run_cmd

