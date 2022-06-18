containertag=guillaumeai/server:labeler

docker build -t $containertag . --no-cache
#docker build -t $containertag . 
sleep 1

if [ "$1" == "" ]; then
docker push $containertag
fi


