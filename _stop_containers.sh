for f in custom*compo*sh
do 
	#echo $f
	$(cat $f |grep "containername=")
	docker stop $containername
	#cat $f | grep "serverhostport=" 
done
