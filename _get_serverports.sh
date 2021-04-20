for f in custom*compo*sh;do echo $f; cat $f |grep "containername=";cat $f | grep "serverhostport="; done
