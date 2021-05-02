containertag=guillaumeai/server:ast-210502-compo

docker build -t $containertag . --no-cache

docker push $containertag


