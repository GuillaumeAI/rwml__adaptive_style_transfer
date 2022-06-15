
source _env.sh
#export scriptfn=custom-cli-start-script-docker-dev-specific-checkpoint.210430.sh
modellisttoinstall=/a/model/models/new_model_to_add__210423.txt
startport=9041
# NOW LOADED in ENV scriptfn=./custom-cli-start-script-docker.sh

c=$startport
for m in $(cat $modellisttoinstall) 
do 
	echo "Adding port $c and starting $m"
	$1 $scriptfn $m $c
       	c=$( expr $c + 1 )
done
