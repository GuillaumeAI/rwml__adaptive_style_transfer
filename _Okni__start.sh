
. $rwroot/_env.sh &>/dev/null || . _env.sh || echo "Could not load env"

#@STCGoal Okni 2204 AICollaborator service management script
#@STCStatus creating it....
ifneecho() {
	local _str="$1"
	if [ "$_str" != "" ]; then echo "$_str";fi
}

ifnotemptyecho() {
	ifneecho "$1"
}


containername="ast_dbginko-v03-210809-864x_300m_s1"
containerstarterinstaller() {
	local _action="$1"
	local _containername="$2"
	local _installcmd="$3"
	local _title="$4"
	local _usage="Usage: containerstarterinstaller <start|stop|remove> <containername> [installcmd] [title]"
	#if [ "$_action" == "" ] ; then echo "$_usage"; return;fi
	#check if first argument is an action
	if ! [[ "$_action" =~ ^(start|stop|remove)$ ]]; then echo "$_usage"; return;fi

	#if [ "$_title" != "" ]; then echo "$_title"; fi
	ifneecho "$_title"

	#local _optionalmsgsuccess="$3"
	#local _optionalmsgfailed="$4"
	if [ "$_action" == "start" ]; then

		local _tst=$(docker ps -a --filter "name=$_containername" | awk '/'"$_containername"'/')
	
		if [ "$_tst" == "" ]; then
			echo "$_containername not installed"
			$_installcmd &> /dev/null && echo "$_containername Installed" || echo "Failed to install $_containername"
		else
			echo "$_containername Sounds great" 
		
			#make sure its started
			docker start $_containername &> /dev/null  #...and dont botther with errors
		fi
	else
		if [ "$_action" == "stop" ]; then 
			docker stop $_containername &> /dev/null && echo "Stopped $_containername"
		fi
	fi
}

#meta server dependencies
metacontainername="ast_meta_server"
#containerstarterinstaller
#sleep 3
containerstarterinstaller start "$metacontainername" ". install-httpd-meta-container.sh" "AST Meta Server"

containerstarterinstaller start "$containername" "echo TODO cmd installer" "Okni 9060 300ki"
#our 

#docker start $containername && echo "Started $containername"
