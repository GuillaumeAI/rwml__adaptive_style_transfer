#!/bin/bash

echo "stopping and deleting $1"

docker stop $1
docker rm $1
