cimsg="$1"
rm -f build/*
git commit server.py -m "$cimsg" && git push 

./rebuild-feat-timelining-21040614.sh 

echo "Launching tests..."
sleep 1
(cd ~/ETCH/example-client-server-04 && pwd && sleep 3 &&  ./clean.sh && echo "<hr>Allo<hr>"> results.html &&  ./build.sh )
