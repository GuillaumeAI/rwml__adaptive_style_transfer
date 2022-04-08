
. $rwroot/_env.sh &>/dev/null || . _env.sh || echo "Could not load env"

#@STCGoal Okni 2204 AICollaborator service management script
#@STCStatus creating it....

containername="ast_dbginko-v03-210809-864x_300m_s1"

#meta server dependencies
metacontainername="ast_meta_server"
#containerstarterinstaller
#sleep 3
containerstarterinstaller start "$metacontainername" "AST Meta Server" ". install-httpd-meta-container.sh"

containerstarterinstaller start "$containername"  "Okni 9060 300ki" "echo TODO cmd installer"
#our 

#docker start $containername && echo "Started $containername"
