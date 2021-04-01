# local Mount
## Environment path related

export mount_root="/a"
export src_root="$mount_root/src"
export modelmountpath="$mount_root/model/models"

export hostdns="orko.guillaumeisabelle.com"
#export callprotocol="http"
#export callurl="$callprotocol://$hostdns:$serverhostport"


# docker
#export docker_cmd="docker run -it --rm "
## Set to desired Docker running Mode (it:iteractive, d:background)
#export docker_mode="it"
export docker_mode="d"


# Web App
## Where is stored the HTML file being served from the host
export httpdserverhtdocs="$src_root/x__etch-a-sketch__210224"

