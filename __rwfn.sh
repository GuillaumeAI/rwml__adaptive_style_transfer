

## @fn astlaunchsslproxy
## @ingroup astutil
## @brief start,stop, install proxy container
## @param string containername name
## @param string serverhostport port
astlaunchsslproxy() {
    containername="$1"
    serverhostport=$2
    #	sport=$3
    #proxycontainertag=$4
    #tdomain=$5
    #thost=$6
    #maxupload=$7
    export proxycontainername=$containername$sslcontainersuffix
    export docker_cmd_proxy="docker run -$docker_mode $docker_run_args --name $proxycontainername "
    
    echo "docker_cmd_proxy=$docker_cmd_proxy"
    
    echo "--------------- Launching SSL Proxy for $containername -----------------"
    sslport=$(expr $serverhostport + 100)
    export proxycontainername=$containername$sslcontainersuffix
    echo "proxycontainername=$proxycontainername"
    echo "\$proxycontainertag=$proxycontainertag"
    echo "--- curl --insecure https://$hostdns:$sslport/stylize"
    
    
    #export thost=svr.astia.xyz
    #export tdomain=api.astia.xyz
    
    
    tport=$serverhostport
    sport=$sslport
    
    
    echo -n "----Proxy Cleaning up $proxycontainername---"
    echo -n "...stop..."
    docker stop $proxycontainername  &> /dev/null
    echo -n ..removing..
    docker rm $proxycontainername  &> /dev/null && echo "--Cleanup done" || echo "-- nothing to cleanup"
    
    echo "...Installing"
    
    
    #     	echo $docker_cmd_proxy \
    #                -e DOMAIN=$tdomain  \
    #                -e TARGET_PORT=$tport  \
    #                -e TARGET_HOST=$thost   \
    #                -e SSL_PORT=$sport   \
    #                -p $sport:$sport \
    #                -e CLIENT_MAX_BODY_SIZE=$maxupload  \
    #                $proxycontainertag
    
    $docker_cmd_proxy \
    -e DOMAIN=$tdomain  \
    -e TARGET_PORT=$tport  \
    -e TARGET_HOST=$thost   \
    -e SSL_PORT=$sport   \
    -p $sport:$sport \
    -e CLIENT_MAX_BODY_SIZE=$maxupload  \
    $proxycontainertag && \
    #        echo "------Oh yeah, should have a proxy running" && \
    echo "https://$tdomain:$sport"
    
}


toshortermodelname()
{
	#DavidBouchardGagnon-v02-210702
    local sourcestring="$1"
    local replacerstr="$2"
    local secondString="$3"
    modelnametmp=$sourcestring
    tmpname="${modelnametmp/$replacerstr/$secondString}"
    echo $tmpname


}


## @fn mkcontainername
## @ingroup astutil
## @brief Make a container name from the model name (previous version of getcontainernamefrommodel)
## @param string modelname folder name of the model
## @param string checkpointno ik
## @param string prefix prefix to the containername (optional)
## @param string suffix suffix to the containername (optional)
## @param string separator (optional)
mkcontainername() {
    local modelname=$1
    local checkpointno="$2"

		if [ "$checkpointno" != "" ]; then checkpointno="$2ik";fi
    local prefix="$3"
    if [ "$prefix" == "" ]; then  prefix="ast_";fi
    
    local suffix="$4"
    
    local separator="$5"
    if [ "$separator" == "" ]; then separator="_";fi
    
    local replacerstr="model_gia-ds-"
    local secondString=""
    local modelnametmp=$modelname
    local tmpname="${modelnametmp/$replacerstr/$secondString}"
    replacerstr="model_gia-"
    modelnametmp=$tmpname
    tmpname="${modelnametmp/$replacerstr/$secondString}"

    #-864_new
    replacerstr="-864_new"
    modelnametmp=$tmpname
    tmpname="${modelnametmp/$replacerstr/$secondString}"


    #daliwill-210123-v02
    tmpname=$(toshortermodelname $tmpname "daliwill-210123-v02" "daliwill02")
    #model_gia-ds-DavidBouchardGagnon-v02-210702-864x_new-30ik
    tmpname=$(toshortermodelname $tmpname "DavidBouchardGagnon-v02-210702" "dbg02")
    #model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new
    tmpname=$(toshortermodelname $tmpname "DavidBouchardGagnon-v01b-210510" "dbg01b")
    #model_gia-ds-wassily_kandinsky_v1_210310_new
    tmpname=$(toshortermodelname $tmpname "wassily_kandinsky_v1_210310" "kandinsky01")
    #model_gia-ds-fpolsonwill_v02_210424_new
    tmpname=$(toshortermodelname $tmpname "fpolsonwill_v02_210424" "polwill02")
    #model_gia-young-picasso-v03-201216_new
    tmpname=$(toshortermodelname $tmpname "young-picasso-v03-201216" "pikwill03")
    #model_gia-young-picasso-v02b-201210-864_new
    tmpname=$(toshortermodelname $tmpname "young-picasso-v02b-201210" "pikwill02b")
    #model_gia-ds-Inktobers-v01-210611-864x_new
    tmpname=$(toshortermodelname $tmpname "Inktobers-v01-210611" "inko01")
    #model_gia-ds-inko-2403-864x_new
    tmpname=$(toshortermodelname $tmpname "inko-2403" "inko2403")
    #model_gia-ds-pierret_ds_210512-864-v02-210527-864_new
    tmpname=$(toshortermodelname $tmpname "pierret_ds_210512-864-v02-210527" "piert02")
    #daliwill-240406-v03
    tmpname=$(toshortermodelname $tmpname "daliwill-240406-v03" "daliwill03")
  
   







   

    secondString=""


    replacerstr="model_gia"
    modelnametmp=$tmpname
    tmpname="${modelnametmp/$replacerstr/$secondString}"
    replacerstr="model_"
    modelnametmp=$tmpname
    tmpname="${modelnametmp/$replacerstr/$secondString}"
    replacerstr="_new"
    modelnametmp=$tmpname
    tmpname="${modelnametmp/$replacerstr/$secondString}"
    replacerstr="-864x"
    modelnametmp=$tmpname
    tmpname="${modelnametmp/$replacerstr/$secondString}"
    replacerstr="864x"
    modelnametmp=$tmpname
    tmpname="${modelnametmp/$replacerstr/$secondString}"
    #if $checkpointno has 4 char, add a '0' 
    origcheckpointno=$checkpointno
    if [ ${#checkpointno} -eq 4 ]; then
	checkpointno="0"$checkpointno
    fi
    local _containername=$prefix$tmpname$separator$checkpointno$suffix

    replacerstr=$origcheckpointno"_"$checkpointno
    secondString=$checkpointno
    modelnametmp=$_containername
    tmpname="${modelnametmp/$replacerstr/$secondString}"
    _containername=$tmpname
    replacerstr="-"$checkpointno 
    secondString="_"$checkpointno
    modelnametmp=$_containername
    tmpname="${modelnametmp/$replacerstr/$secondString}"
    _containername=$tmpname
    echo $_containername
}

## @fn mkcontainername2403
## @ingroup astutil
## @brief Make a container name from the model name (previous version of getcontainernamefrommodel)
## @param string modelname folder name of the model
## @param string checkpointno ik
## @param string prefix prefix to the containername (optional)
## @param string suffix suffix to the containername (optional)
## @param string separator (optional)
mkcontainername2403() {
    local modelname=$1
    local checkpointno=$2
    local prefix="$3"
    if [ "$prefix" == "" ]; then  prefix="ast_";fi
    
    local suffix="$4"
    
    local separator="$5"
    if [ "$separator" == "" ]; then separator="_";fi
    
    local replacerstr="model_gia-ds-"
    local secondString=""
    local modelnametmp=$modelname
    local tmpname="${modelnametmp/$replacerstr/$secondString}"

    replacerstr="_new"
    modelnametmp=$tmpname
    tmpname="${modelnametmp/$replacerstr/$secondString}"

    replacerstr="model_gia-"
    modelnametmp=$tmpname
    tmpname="${modelnametmp/$replacerstr/$secondString}"
    replacerstr="model_gia"
    modelnametmp=$tmpname
    tmpname="${modelnametmp/$replacerstr/$secondString}"
    replacerstr="model_"
    modelnametmp=$tmpname
    tmpname="${modelnametmp/$replacerstr/$secondString}"
    replacerstr="_new"
    modelnametmp=$tmpname
    tmpname="${modelnametmp/$replacerstr/$secondString}"
    
    replacerstr="-864x"
    modelnametmp=$tmpname
    tmpname="${modelnametmp/$replacerstr/$secondString}"
    
    local _containername=$prefix$tmpname$separator$checkpointno'ik'$suffix
    echo $_containername
}




## @fn getfnamefrommodel
## @ingroup astutil
## @brief Make a fname from the model name for metadata
## @param string modelname folder name of the model
## @param string prefix prefix to the containername (optional)
## @param string suffix suffix to the containername (optional)
getfnamefrommodel() {
    local _modelname=$1
    local _suffix="$2"
    local _prefix="$3"
    local r="$1"
    local dspath="$(pwd)/ds-modelname-fname"
    if [ -e "$dspath" ]; then dspath="$(pwd)/ds-modelname-fname"
    else
        if [ -e "$rwroot" ]; then dspath="$rwroot/ds-modelname-fname"
    else echo "Define rwroot env var, most likely : export rwroot=/c/usr/src/rwml__adaptive_style_transfer" ; return 1; fi
    fi
    if [ -e "$dspath" ] ; then
        for ml in $(cat $dspath); do
            _m=$(echo $ml | tr ";" " " | awk '// { print $1 }')
            _f=$(echo $ml | tr ";" " " | awk '// { print $2 }')
            r=$(echo $_modelname | sed -e 's/'"$_m"'/'"$_f"'/g')
            
        done
        r=$_prefix$r$_suffix
        r="${r/-864x_new/}"
        r="${r/-864x_/}"
        r="${r/-864x/}"
        r="${r/_new/}"
        r="${r/model_gia-ds-/}"
        r="${r/model_gia-/}"
        r="${r/model_/}"
        r="${r/-x/}"
        echo $r
        #echo $_prefix$r$_suffix
    fi
    
}



## @fn getcontainernamefrommodel
## @ingroup astutil
## @brief Make a containername from the model name for service (next version of mkcontainername)
## @param string modelname folder name of the model
## @param string suffix suffix to the containername (optional)
## @param string chk model checkpoint
getcontainernamefrommodel() {
    local _modelname="$1"
    local cnamesuffix="$2"
    local _chk="$3"
    local cnameprefix="ast_"
    local fname="$(getfnamefrommodel $1)"
    local r="$cnameprefix$fname$_chk$cnamesuffix"
    
    echo $r
    
}

## @fn getcontainernamefrommodelvar
## @ingroup astutil
## @brief Make a containername from the model name for service
## @param string modelname folder name of the model
## @param string suffix suffix to the containername (optional)
## @param string chk model checkpoint
getcontainernamefrommodelvar() {
    export containername=$(getcontainernamefrommodel "$1" "$2" "$3")
}
