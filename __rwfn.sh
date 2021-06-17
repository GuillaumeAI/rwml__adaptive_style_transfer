



astlaunchsslproxy() {

        echo "------------------Launching SSL Proxy --------------------------"
        sslport=$(expr $serverhostport + 100)
        export proxycontainername=$containername-xi
        echo "--- curl --insecure https://$hostdns:$sslport/stylize"


        #export thost=svr.astia.xyz
        #export tdomain=api.astia.xyz


        tport=$serverhostport
        sport=$sslport


        echo "----------Proxy Cleaning up $proxycontainername-------"
        docker stop $proxycontainername  &> /dev/null
        docker rm $proxycontainername  &> /dev/null && echo "--Cleanup done" || echo "-- nothing to cleanup"
        echo "-----------Installing $proxycontainername ------------"


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

