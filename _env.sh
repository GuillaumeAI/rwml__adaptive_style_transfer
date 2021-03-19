


# ARTIST : CHG Model name

export modelname="model_gia-ds-wassily_kandinsky_v1_210310_new-210ik"



# ARTIST : Probably dont change anything bellow 

## Environment path related
export modelmountpath="/mnt/c/model/models"


## Container related
export containermodelroot="/data/styleCheckpoint"


# Infrastructure related
export containertag="guillaumeai/ast:runwayml_picasso_2103180139"

export serverport=8000
export serverhostport=9000
export docker_cmd="docker run -it --rm "
export run_cmd="bash"


# Loads an ENV for the current host if exist
hostenvfile="_henv_$HOSTNAME.sh"
if [ -f $hostenvfile ]; then
    . ./$hostenvfile
else
    echo " ./$hostenvfile does not exist, create it if you require to define specific to platform variable or overwrite some."
fi
