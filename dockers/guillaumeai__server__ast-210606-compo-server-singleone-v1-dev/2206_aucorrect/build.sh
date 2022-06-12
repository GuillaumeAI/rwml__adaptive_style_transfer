containertag=guillaumeai/server:ast-210606-singleone-v1-dev-acc
copy -f ../../../compo-singleone-v1-dev-acc.py . && \
docker build -t $containertag . --no-cache
#docker build -t $containertag . 
sleep 1

if [ "$1" == "" ]; then
docker push $containertag
fi


