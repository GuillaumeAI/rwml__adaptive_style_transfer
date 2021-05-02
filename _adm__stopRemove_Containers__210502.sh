#!/bin/bash

# get all running docker container names

if [ "$1" != "" ] && [ "$1" != "--list" ] && [ "$1" != "--rm" ] ;then
	containers=$(docker ps | awk '{if(NR>1) print $NF}' | grep $1)
else 
	containers=$(docker ps | awk '{if(NR>1) print $NF}') 

fi

#containers=$(docker ps | awk '{if(NR>1) print $NF}')
host=$(hostname)

# loop through all containers

if [ "$1" == "" ] ||  [ "$1" == "--rm" ]  ; then
	#ask if we remove
	echo "----------------------------------------------------------"
	echo "$containers"
	echo "----------------"
	echo "Do you wish to stop/remove all containers above (y/n) ?"
	select yn in "y" "n"; do
    		case $yn in 
			y ) break;break;;
			n ) exit;;
		esac
		break;
	done
fi

for container in $containers
do
  echo "Container: $container"
  if [ "$1" != "--list" ];then
	  (docker stop $container  ; docker rm $container) &
	  sleep 1
  fi

  

  echo ================================
done
