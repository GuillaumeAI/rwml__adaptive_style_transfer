#!/bin/bash

# get all running docker container names

if [ "$1" != "" ] && [ "$1" != "--list" ] && [ "$1" != "--rm" ] ;then
	containers=$(docker ps|awk '{if(NR>1) print $NF}'| grep $1)
else 
	containers=$(docker ps|awk '{if(NR>1) print $NF}') 

fi

#containers=$(docker ps | awk '{if(NR>1) print $NF}')
host=$(hostname)

# loop through all containers

if [ "$1" == "" ] ||  [ "$1" == "--rm" ]  ; then
	#ask if we remove
	echo "----------------------------------------------------------"
	echo "$containers"
	echo "----------------"
	echo "Wish to Stop/remove all containers above."
	read -r -p "Are You Sure? [Y/n] " input
   	
	case $input in
    		[yY][eE][sS]|[yY])
			echo "Deletion starting..."	
			for container in $containers
			do
				echo "Container: $container"
				if [ "$1" != "--list" ];then
					(docker stop $container  ; docker rm $container) &
					sleep 1
				fi
				echo ================================
			done
		;;

		[nN][oO]|[nN]) 
			 echo "Cancelling removal";
		;;
		*)
 			echo "Invalid input..."
 			exit 1
 		;;	
	esac
	
	
fi

if [ "$1" == "--list" ]  ||  [ "$1" == "--ls" ];then
#	echo "------Listing containers ---------"
	for container in $containers
	do
		export msg="$container"
		if [ "$2" == "--port" ]; then

			cports=$(docker container port $container|tr ":" " "|awk '/0.0.0.0/ { print $4}')
			#echo "$cports"
		for cport in $cports; do
			       #msg=$cport':'$container
			       msg2=$cport':'$container
		#	       echo "$msg2"
			      export msg=" $msg2"
		      done
		      #echo "$res" | sort
	       else
		       echo " "
		fi
		
		echo "$msg" | sort

		
	done
fi


