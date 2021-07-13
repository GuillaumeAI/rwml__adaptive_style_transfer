(cd /a/src/rwml__adaptive_style_transfer;./_adm__stopRemove_Containers__210502.sh --list --port  | sort|tr ":" " " | awk '/90/ {print substr($1,3)  " #"$2}'  )


