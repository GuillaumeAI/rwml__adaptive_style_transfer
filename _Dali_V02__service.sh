#!/bin/bash

. $rwroot/_env.sh &>/dev/null || . _env.sh || echo "Could not load env"

#@STCGoal Okni 2204 AICollaborator service management script
#@STCStatus creating it....

containername="ast_daliwill-210123-v02-150ik_150m_s1"

#meta server dependencies
metacontainername="ast_meta_server"
#containerstarterinstaller
#sleep 3
_action="$1"
if [ "$_action" == "" ] ; then _action="start";fi

containerstarterinstaller $_action "$metacontainername" "AST Meta Server" ". install-httpd-meta-container.sh"

#custom-cli-start-script-docker-dev-specific-checkpoint-singleone.210606.sh 
containerstarterinstaller $_action "$containername"  "Dali 9020" ". install-dali-v02-150ik.sh"
#our 

#docker start $containername && echo "Started $containername"
