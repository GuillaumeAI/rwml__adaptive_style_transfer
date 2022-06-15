
for container in $(cat compo__210701_ds) ; do 

	if [ "$1" == "--start" ] ; then
		echo "Starting $container" ; docker start $container
	else 
		echo "Stopping $container";docker stop $container
	fi

done

