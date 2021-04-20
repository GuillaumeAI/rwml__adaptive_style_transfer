


# ARTIST : CHG Model name

export modelname="model_gia-ds-wassily_kandinsky_v1_210310_new-210ik"



# ARTIST : Probably dont change anything bellow 

## Environment path related

export modelmountpath="/a/model/models"


## Container related
export containermodelroot="/data/styleCheckpoint"


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
export compocontainerrepotag="ast-210420-compo"
export compocontainerrepo="$compocontainerns/$compocontainerreponame"

export compocontainertag="$compocontainerrepo:$compocontainerrepotag"


export serverport=8000
export serverhostport=9000

export callprotocol="http"

# docker
#export docker_cmd="docker run -it --rm "
## Set to desired Docker running Mode (it:iteractive, d:background)
#@STCIssue Where are those vars now ??
#export docker_mode="it"
export docker_mode="d"
export docker_run_args="--rm "
export docker_run_args="--restart unless-stopped "
#export docker_cmd="docker run -$docker_mode --rm "
#if [ $docker_mode = "d" ] ; then echo "Background infrastructure mode activated (will run in background until stopped or server rebooted)" ; fi
#if [ $docker_mode = "it" ] ; then echo "Foreground infrastructure mode activated (require to keep the startup shell active)" ; fi


# Deprecating, the container starts its own command
export run_cmd="bash"


# Loads an ENV for the current host if exist
hostenvfile="_henv_$HOSTNAME.sh"
if [ -f $hostenvfile ]; then
    . ./$hostenvfile
else
    echo " ./$hostenvfile does not exist, create it if you require to define specific to platform variable or overwrite some."
fi

echo "Environment is loaded"

