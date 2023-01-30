(cdm &> /dev/null;for m in $(ls -d model_*) ; do echo "$(mckinfo $m)   $m" ; done)

