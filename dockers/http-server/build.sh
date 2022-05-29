containertag=guillaumeai/server:http-server
docker build -t $containertag .
docker push $containertag
