. $HOME/.bashrc &>/dev/null

pattern=ap2404
if [ "$1" != "" ];then pattern=$1;fi

for c in $(dkps|awk '{print $14}'|grep $pattern);do dkcrm $c;done
