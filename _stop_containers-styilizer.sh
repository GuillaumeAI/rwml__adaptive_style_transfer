for f in custom-start-docker-ast-st*sh
do 
	#echo $f
	$(cat $f |grep "containername=")
	docker stop $containername
	#cat $f | grep "serverhostport=" 
done
