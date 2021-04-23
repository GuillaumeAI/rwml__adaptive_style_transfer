for f in custom-start-docker-ast-st*sh
do 
	#echo $f
	$(cat $f |grep "containername=")
	docker start $containername
	#cat $f | grep "serverhostport=" 
done
