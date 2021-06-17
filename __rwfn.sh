



astlaunchsslproxy() {
	containername="$1"
	serverhostport=$2
	sport=$3
	#proxycontainertag=$4
	#tdomain=$5
	#thost=$6
	#maxupload=$7
	export proxycontainername=$containername-xi
	export docker_cmd_proxy="docker run -$docker_mode $docker_run_args --name $proxycontainername "

	echo "docker_cmd_proxy=$docker_cmd_proxy"

        echo "--------------- Launching SSL Proxy for $containername -----------------"
        sslport=$(expr $serverhostport + 100)
        export proxycontainername=$containername-xi
	echo "proxycontainername=$proxycontainername"
	echo "\$proxycontainertag=$proxycontainertag"
        echo "--- curl --insecure https://$hostdns:$sslport/stylize"


        #export thost=svr.astia.xyz
        #export tdomain=api.astia.xyz


        tport=$serverhostport
        sport=$sslport


        echo "----------Proxy Cleaning up $proxycontainername-------"
        docker stop $proxycontainername  &> /dev/null
        docker rm $proxycontainername  &> /dev/null && echo "--Cleanup done" || echo "-- nothing to cleanup"
        echo "-----------Installing $proxycontainername ------------"


echo     $docker_cmd_proxy \
                -e DOMAIN=$tdomain  \
                -e TARGET_PORT=$tport  \
                -e TARGET_HOST=$thost   \
                -e SSL_PORT=$sport   \
                -p $sport:$sport \
                -e CLIENT_MAX_BODY_SIZE=$maxupload  \
                $proxycontainertag
		
		$docker_cmd_proxy \
                -e DOMAIN=$tdomain  \
                -e TARGET_PORT=$tport  \
                -e TARGET_HOST=$thost   \
                -e SSL_PORT=$sport   \
                -p $sport:$sport \
                -e CLIENT_MAX_BODY_SIZE=$maxupload  \
                $proxycontainertag && \
        echo "------Oh yeah, should have a proxy running"
}

