
git commit . -m rebuild
git pull
git push
echo "# Rebuild the container..."
sleep 1
./build-feat-timelining-21040614.sh 
echo "... Rebuilt container"
echo "# Re-creating and launching the container $containertag"
sleep 1
./feat-timelining-21040614-start-docker-ast-cezanne-vo-165ik-port-9112.sh

echo "--- Should be ready to launch test "

