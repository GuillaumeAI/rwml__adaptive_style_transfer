


for c in $(dkclsstopped | awk '/ast/ { print $1}'); do dkcrm $c;done

