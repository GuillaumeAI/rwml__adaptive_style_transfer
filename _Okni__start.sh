

#@STCGoal Okni 2204 AICollaborator service management script
#@STCStatus creating it....

containername="ast_dbginko-v03-210809-864x_300m_s1"
containerstarter() {
	local _containername="$1"
	local _installcmd="$2"
	local _optionalmsgsuccess="$3"
	local _optionalmsgfailed="$4"
	local _tst=$(docker ps -a --filter "name=$_containername" | awk '/'"$_containername"'/')
	if [ "$_tst" == "" ]; then
		echo "$_containername not installed"
			        $_installcmd &> /dev/null && echo "$_containername Installed" || echo "Failed to install $_containername"
	else
		echo "$_containername Sounds great" 
		#make sure its started
		docker start $_containername &> /dev/null  #...and dont botther with errors
	fi
}

#meta server dependencies
metacontainername="ast_meta_server"
tst=$(docker ps -a --filter "name=$metacontainername" | awk '/'"$metacontainername"'/')
if [ "$tst" == "" ]; then 
	echo "not installed"
	. install-httpd-meta-container.sh &> /dev/null && echo "AST Meta Server Installed"
else 
	echo "AST Meta Server Sounds great" 
	docker start ast_meta_server &> /dev/null #|| (echo "ohoh, sounds like AST Meta Server not installed, installing :)" && . install-httpd-meta-container.sh &> /dev/null && echo "AST Meta Server Installed")
fi

#our 

docker start $containername && echo "Started $containername"
