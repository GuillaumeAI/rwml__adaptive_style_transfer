#!/bin/bash
# Will be moved to all host - keep it here to stay compatible with new host and ol0d ones
export httpdserverhtdocs=/a/src/x__etch-a-sketch__210224
source _env.sh

# Exports...
## docker_run_args
## Sample 
### docker run -dit --name my-apache-app -p 8080:80 -v "$PWD":/usr/local/apache2/htdocs/ httpd:2.4
export httpdserverport=80
export httpdcontainerport=80
export httpdcontainerhtdocs=/usr/local/apache2/htdocs

#export httpdserverhtdocs=/a/src/x__etch-a-sketch__210224 # Moving it to the host env
export httpdcontainertag="guillaumeai/server:httpd"
export httpcontainername=ast_webapp

#echo docker run -d $docker_run_args --name $httpcontainername -p $httpdserverport:$httpdcontainerport -v $(pwd):/work -v $httpdserverhtdocs:$httpdcontainerhtdocs -v /a:/a -v /a:$httpdcontainerhtdocs/a $httpdcontainertag
echo "--- Cleaning up if existing container----"
docker rm $httpcontainername
echo "--- Cleanup done (if was required, otherwise ignore the errors-------"
echo "---------------------------------------------------------------------"

echo "-------- Installing and running the container : $httpdcontainertag --"
echo "-- Host HTTPDocPath: $httpdserverhtdocs          -"
echo "-- Being served at port : $httpdserverport:$httpdcontainerport     -"
echo "--------------------------------------------------------------------"

docker run -d $docker_run_args --name $httpcontainername -p $httpdserverport:$httpdcontainerport -v $(pwd):/work -v $httpdserverhtdocs:$httpdcontainerhtdocs -v /a:/a -v /a:$httpdcontainerhtdocs/a $httpdcontainertag

echo "HTTPD Should have been install as a container that will always restart unless stopped and will run on this host :$httpdserverport port."
echo "  Most likeli the url should be:   http://$hostdns:$httpdserverport"

