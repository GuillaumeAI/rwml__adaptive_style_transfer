



astlaunchsslproxy() {
	containername="$1"
	serverhostport=$2
#	sport=$3
	#proxycontainertag=$4
	#tdomain=$5
	#thost=$6
	#maxupload=$7
	export proxycontainername=$containername$sslcontainersuffix
	export docker_cmd_proxy="docker run -$docker_mode $docker_run_args --name $proxycontainername "

	echo "docker_cmd_proxy=$docker_cmd_proxy"

        echo "--------------- Launching SSL Proxy for $containername -----------------"
        sslport=$(expr $serverhostport + 100)
        export proxycontainername=$containername$sslcontainersuffix
	echo "proxycontainername=$proxycontainername"
	echo "\$proxycontainertag=$proxycontainertag"
        echo "--- curl --insecure https://$hostdns:$sslport/stylize"


        #export thost=svr.astia.xyz
        #export tdomain=api.astia.xyz


        tport=$serverhostport
        sport=$sslport


        echo -n "----Proxy Cleaning up $proxycontainername---"
        echo -n "...stop..."  
        docker stop $proxycontainername  &> /dev/null
        echo -n ..removing..
        docker rm $proxycontainername  &> /dev/null && echo "--Cleanup done" || echo "-- nothing to cleanup"

        echo "...Installing"


#     	echo $docker_cmd_proxy \
#                -e DOMAIN=$tdomain  \
#                -e TARGET_PORT=$tport  \
#                -e TARGET_HOST=$thost   \
#                -e SSL_PORT=$sport   \
#                -p $sport:$sport \
#                -e CLIENT_MAX_BODY_SIZE=$maxupload  \
#                $proxycontainertag
		
		$docker_cmd_proxy \
                -e DOMAIN=$tdomain  \
                -e TARGET_PORT=$tport  \
                -e TARGET_HOST=$thost   \
                -e SSL_PORT=$sport   \
                -p $sport:$sport \
                -e CLIENT_MAX_BODY_SIZE=$maxupload  \
                $proxycontainertag && \
#        echo "------Oh yeah, should have a proxy running" && \
	echo "https://$tdomain:$sport"
		
}


mkcontainername() {
	local modelname=$1
	local checkpointno=$2
	local prefix="$3"
	if [ "$prefix" == "" ]; then  prefix="ast_";fi
	
	local suffix="$4"
	
	local separator="$5"
	if [ "$separator" == "" ]; then separator="_";fi

	local replacerstr="model_gia-ds-"
	local secondString=""
	local modelnametmp=$modelname
	local tmpname="${modelnametmp/$replacerstr/$secondString}"
	replacerstr="model_gia-"
        modelnametmp=$tmpname
        tmpname="${modelnametmp/$replacerstr/$secondString}" 
	replacerstr="model_gia"
	modelnametmp=$tmpname
	tmpname="${modelnametmp/$replacerstr/$secondString}"
	replacerstr="model_"
	modelnametmp=$tmpname
	tmpname="${modelnametmp/$replacerstr/$secondString}"
	replacerstr="_new"
	modelnametmp=$tmpname
	tmpname="${modelnametmp/$replacerstr/$secondString}"
	local _containername=$prefix$tmpname$separator$checkpointno$suffix
	echo $_containername
}



getfnamefrommodel() {
        local _modelname=$1
        local r="$1"
        for ml in $(cat ds-modelname-fname); do
                m=$(echo $ml | tr ";" " " | awk '// { print $1 }')
                f=$(echo $ml | tr ";" " " | awk '// { print $2 }')
                r=$(echo $r | sed -e 's/'"$m"'/'"$f"'/g')

        done
        echo $r

}


