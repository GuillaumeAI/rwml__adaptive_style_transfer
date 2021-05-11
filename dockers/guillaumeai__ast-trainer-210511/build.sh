containertag=guillaumeai/server:ast-trainer-210511

echo "This is a FAILED attempt to install what is required to train on this infrastructure."
exit 1
docker build -t $containertag . $1
#--no-cache
#docker build -t $containertag . 

#docker push $containertag


