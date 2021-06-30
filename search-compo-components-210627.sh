# Get the compo modelnames and port

for f in *start*compo-*.sh; do echo $'\n';echo "#     $f"; cat $f | grep hostport; cat $f | grep "modelname=" ; cat $f | grep "model2name=";cat $f | grep "model3name=" ;done
