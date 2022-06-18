containertag=guillaumeai/server:ast-210502-compo-three

docker build -t $containertag . --no-cache
#docker build -t $containertag . 

docker push $containertag


