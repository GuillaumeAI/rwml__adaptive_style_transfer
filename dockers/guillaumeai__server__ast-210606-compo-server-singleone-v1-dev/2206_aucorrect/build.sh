containertag=guillaumeai/server:ast-210606-singleone-v1-dev-acc
cp -f ../../../compo-singleone-v1-dev-acc.py . && \
docker build -t $containertag . $1
#--no-cache
#docker build -t $containertag . 
sleep 1

echo "docker run -it --rm -v \$(pwd):/work $containertag "

if [ "$1" == "" ]; then
echo "Pushing"
#docker push $containertag
fi


