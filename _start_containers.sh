for f in custom*compo*sh
do 
	#echo $f
	$(cat $f |grep "containername=")
	docker start $containername
	#cat $f | grep "serverhostport=" 
done
