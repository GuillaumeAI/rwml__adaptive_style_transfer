containertag=guillaumeai/server:ast-base-210420

docker build -t $containertag . --no-cache

docker push $containertag


