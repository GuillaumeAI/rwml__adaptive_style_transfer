source $HOME/.bashrc &>/dev/null
source _env.sh
source __rwfn.sh


## --@STCGoal Drawing Stylization Mount model checkpoint

m=model_gia-ds-ap2404-864x_new


export modelname="$m"
export startserverport=9461

# The resolution of the two passes
export PASS1IMAGESIZE=2248

chks="$(mckinfo $m)"


export serverhostport=$startserverport

for c in $chks ; do
	export	 checkpointno=$c


	#export checkpointno=345
	# @mkcontainername $m 
	export containername=$(mkcontainername $m $checkpointno)
	#echo "Containername: $containername"
	#sleep 12
	#export containername='pikawill03a2-'$c'uk'

	if [ "$1" == "--rm" ]; then
		echo -n "Removing container $containername.."
		dkcrm $containername  &>/dev/null && echo "..removed"
	else
		#echo "Checking $containername is running : curl http://localhost:$serverhostport/stylize"
		do_it=$(curl "http://localhost:$serverhostport/stylize" &>/dev/null && echo "no"||echo "yes")			
		if [ "$1" == "--force" ]; then
			do_it="yes"
			echo "Forcing launch"
			sleep 1
		fi

		export docker_mode="d"

		export docker_run_args="--restart unless-stopped "

		if [ "$do_it" == "yes" ]; then
			
			source custom-cli-start-script-docker-dev-specific-checkpoint-singleone.210606.sh \
				$modelname \
				$serverhostport \
				$PASS1IMAGESIZE \
       				$checkpointno
		else 
			echo "$containername already running, Skipping $serverhostport"
		fi
		serverhostport=$(expr $serverhostport + 1)
		
	fi

done


## MODELNAME APIPORT PASS1IMAGESIZE CHECKPOINT_NUM [--fg (debug)] "
#source __launch-docker-compo-doubletwo-v1-dev.sh $1 $2


