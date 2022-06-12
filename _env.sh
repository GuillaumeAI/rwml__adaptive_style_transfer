

declare -r RWROOT=$(cd "$(dirname "$0"  &> /dev/null)" && pwd) &> /dev/null

# ARTIST : CHG Model name
. $binroot/__fn.sh
. $RWROOT/__rwfn.sh

# ARTIST : Probably dont change anything bellow 

export astia_server_file_location='/tmp/astia'
#chmod 777 $astia_server_file_location

export modelmountpath="/a/model/models"

#meta svr
export metahttpdocroot=/www/astia
export metahttpdocastinfopath=$metahttpdocroot/info
export httpserverserverhtdocs=$metahttpdocastinfopath #keep it compatible
export metaglobalregistryfeature="0" #1 enable
export globallocationpath=/home/jgi/astiapreviz
export globallocationpath=/www/astia

# Proxy Conf
export thost=svr.astia.xyz
export tdomain=api.astia.xyz
export maxupload=40M 
#export proxycontainertag=fsouza/docker-ssl-proxy
export sslcontainersuffix="-sslproxy"
export proxycontainertag=guillaumeai/server:sslproxy


## Environment path related


export admscript=./_adm__stopRemove_Containers__210502.sh
alias dcls="$admscript --list --port"

## Container related
export containermodelroot="/data/styleCheckpoint"

# Service script
## used to start container simplified
export scriptfn=./custom-cli-start-script-docker.sh

# Infrastructure related
#export containertag="guillaumeai/ast:runwayml_picasso_2103180139"
export containerns="guillaumeai"
export containerreponame="server"

# Testing the new version
export containerrepotag="ast-2103220014"
#export containerrepotag="ast-210420" #a new release but we dont need it yet
export containerrepo="$containerns/$containerreponame"
#export containertag="guillaumeai/server:ast"
export containertag="$containerrepo:$containerrepotag"

#COMPO Container
export compocontainerns="guillaumeai"
export compocontainerreponame="server"
# export compocontainerrepotag="ast-210420-compo"
export compocontainerrepotag="ast-210502-compo"
export compocontainerrepo="$compocontainerns/$compocontainerreponame"
export compocontainertag="$compocontainerrepo:$compocontainerrepotag"

#COMPO Three Container
export compo3containerns="guillaumeai"
export compo3containerreponame="server"
export compo3containerrepotag="ast-210502-compo-three"
export compo3containerrepo="$compo3containerns/$compo3containerreponame"
export compo3containertag="$compo3containerrepo:$compo3containerrepotag"
#guillaumeai/server:ast-210502-compo-three

#COMPO Three v2 devContainer
export compo3v2devcontainerns="guillaumeai"
export compo3v2devcontainerreponame="server"
export compo3v2devcontainerrepotag="ast-210502-compo-three-v2-dev"
export compo3v2devcontainerrepo="$compo3v2devcontainerns/$compo3v2devcontainerreponame"
export compo3v2devcontainertag="$compo3v2devcontainerrepo:$compo3v2devcontainerrepotag"

#COMPO Two v2 devContainer
export compo2v2devcontainerns="guillaumeai"
export compo2v2devcontainerreponame="server"
export compo2v2devcontainerrepotag="ast-210518-compo-two-v2-dev"
export compo2v2devcontainerrepo="$compo2v2devcontainerns/$compo2v2devcontainerreponame"
export compo2v2devcontainertag="$compo2v2devcontainerrepo:$compo2v2devcontainerrepotag"


#COMPO DoubleTwo v1 devContainer
export compo2dtv1devcontainerns="guillaumeai"
export compo2dtv1devcontainerreponame="server"
export compo2dtv1devcontainerrepotag="ast-210518-compo-doubletwo-v1-dev"
export compo2dtv1devcontainerrepo="$compo2dtv1devcontainerns/$compo2dtv1devcontainerreponame"
export compo2dtv1devcontainertag="$compo2dtv1devcontainerrepo:$compo2dtv1devcontainerrepotag"

#guillaumeai/server:ast-210606-singleone-v1-dev

export singleonev1devcontainerns="guillaumeai"
export singleonev1devcontainerreponame="server"
export singleonev1devcontainerrepotag="ast-210606-singleone-v1-dev"
export singleonev1devcontainerrepo="$singleonev1devcontainerns/$singleonev1devcontainerreponame"
export singleonev1devcontainertag="$singleonev1devcontainerrepo:$singleonev1devcontainerrepotag"
export zeussingleonev1devcontainerns="jgwill"
export zeussingleonev1devcontainerreponame="zeus"
export zeussingleonev1devcontainerrepotag="ast-210606s1v1"

export zeussingleonev1devcontainerrepo="$zeussingleonev1devcontainerns/$zeussingleonev1devcontainerreponame"
export zeussingleonev1devcontainertag="$zeussingleonev1devcontainerrepo:$zeussingleonev1devcontainerrepotag"

export serverport=8000
#export serverhostport=9000

export callprotocol="http"

#### Imports from gixast to use droxul

export cuserhome=/root
export dkrun_mount_droxconf_config_args="-v $HOME/.dropbox_uploader:$cuserhome/.dropbox_uploader -v $HOME:/config"
#binroot support in container
export dkrun_mount_binroot=" -v $binroot:$binroot "
##<<<#
# $dkrun_mount_binroot $dkrun_mount_droxconf_config_args

# docker
#export docker_cmd="docker run -it --rm "
## Set to desired Docker running Mode (it:iteractive, d:background)
#@STCIssue Where are those vars now ??
#export docker_mode="it"
export docker_mode="d"

#export docker_run_args="--rm "
export docker_run_args="--restart unless-stopped "
#export docker_cmd="docker run -$docker_mode --rm "
#if [ $docker_mode = "d" ] ; then echo "Background infrastructure mode activated (will run in background until stopped or server rebooted)" ; fi
#if [ $docker_mode = "it" ] ; then echo "Foreground infrastructure mode activated (require to keep the startup shell active)" ; fi


# Deprecating, the container starts its own command
export run_cmd="bash"


# Loads an ENV for the current host if exist
hostenvfile="_henv_$HOSTNAME.sh"
if [ -f $RWROOT/$hostenvfile ]; then
    . $RWROOT/$hostenvfile
#else
#	if [ ! -e "~/.bequiet" ] ; then    echo " $RWROOT/$hostenvfile does not exist, create it if you require to define specific to platform variable or overwrite some."
#	fi
fi

#echo "Environment is loaded"


if [ -f $RWROOT/.env ]; then
    . $RWROOT/.env
fi


