

thost=etchai.guillaumeisabelle.com
tdomain=etchai.guillaumeisabelle.com



tport=80
sport=443
maxupload=40M
containername=https-proxy-etchai
docker stop $containername &> /dev/null
docker rm $containername &> /dev/null
docker run -d --name $containername \
-e DOMAIN=$tdomain  \
-e TARGET_PORT=$tport  \
-e TARGET_HOST=$thost   \
-e SSL_PORT=$sport   \
-p $sport:$sport \
-e CLIENT_MAX_BODY_SIZE=$maxupload  \
fsouza/docker-ssl-proxy


