#!/bin/bash
#@STCGoal Install Meta AST Server
#@STCStatus DEPRECATED.  Will be moved to all host - keep it here to stay compatible with new host and old ones
export httpserverserverhtdocs=/www/astia/info #todo override in _env.sh
. _env.sh
mkdir -p $httpserverserverhtdocs && echo "Created folders to store Meta at: $httpserverserverhtdocs"


# Exports...
## docker_run_args
## Sample 
### docker run -dit --name my-apache-app -p 8080:80 -v "$PWD":/usr/local/apache2/htdocs/ httpserver:2.4
export httpserverserverport=8999
export httpservercontainerport=8080
export httpservercontainerhtdocs=/wwwmeta

#export httpserverserverhtdocs=/a/src/x__etch-a-sketch__210224 # Moving it to the host env
export httpservercontainertag="docker.io/guillaumeai/server:http-server"
export httpcontainername=ast_meta_server

#echo docker run -d $docker_run_args --name $httpcontainername -p $httpserverserverport:$httpservercontainerport -v $(pwd):/work -v $httpserverserverhtdocs:$httpservercontainerhtdocs -v /a:/a -v /a:$httpservercontainerhtdocs/a $httpservercontainertag
echo "--- Cleaning up if existing container----"
docker stop $httpcontainername
docker rm $httpcontainername
echo "--- Cleanup done (if was required, otherwise ignore the errors-------"
echo "---------------------------------------------------------------------"

echo "-------- Installing and running the container : $httpservercontainertag --"
echo "-- Host HTTP-SERVERocPath: $httpserverserverhtdocs          -"
echo "-- Being served at port : $httpserverserverport:$httpservercontainerport     -"
echo "--------------------------------------------------------------------"

#docker run -d $docker_run_args
#docker run -it --rm 
docker run -d $docker_run_args --name $httpcontainername -p $httpserverserverport:$httpservercontainerport -v $(pwd):/work -v $httpserverserverhtdocs:$httpservercontainerhtdocs -v /a:/a -v /a:$httpservercontainerhtdocs/a $httpservercontainertag http-server -p 8080 /wwwmeta

echo "HTTP-SERVER Should have been install as a container that will always restart unless stopped and will run on this host :$httpserverserverport port."
echo "  Most likeli the url should be:   http://$hostdns:$httpserverserverport"

