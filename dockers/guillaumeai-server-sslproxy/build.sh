containertag=guillaumeai/server:sslproxy
docker build -t $containertag . && docker push $containertag

