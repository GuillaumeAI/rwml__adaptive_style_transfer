containertag=guillaumeai/server:ast-210502-compo-three-v2-dev-base

docker build -t $containertag . --no-cache
#docker build -t $containertag . 

if [ "$1" == "" ]; then
	docker push $containertag
fi


