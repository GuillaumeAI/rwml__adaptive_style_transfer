msg="$1";git commit compo-server.py model.py main.py -m "$msg" && git push && (cd /mnt/c/usr/src/rwml__adaptive_style_transfer/dockers/guillaumeai__server__ast-210420-compo ; source build.sh)
sleep 2 
./test-compo-launch-docker-ast-dev.sh

