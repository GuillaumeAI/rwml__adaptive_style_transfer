containertag=guillaumeai/server:ast-210420

docker build -t $containertag . --no-cache

docker push $containertag


