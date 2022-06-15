export crpf=$TMP/_tmp_crop
export dropbox_root_dir=/lib/results/compo-three-v2-dev
export dropbox_root_dir=/Downloads__2101
export infile=$crpf.jpg
export out_ext=jpg
export cropscript=_crop.sh
export outdir_prefix='ohcropIMG00250_1_'
export outfile_prefix="result_a_"
#to load env of context
export lastContextEnv="_lastContextEnv.sh"
export callhost="as.guillaumeisabelle.com"
export callhostB="orko.guillaumeisabelle.com"
export callprotocol="http"
export callmethod="stylize"
export callportbase=90
export lseqScript=./test-compo-three-v2-dev-args.sh
export giaImg2Base64RequestScript=gia-ast-img2stylize-request
export giaAstResponseStylizedToFileScript=gia-ast-response-stylizedImage2file
export callContentType="Content-Type: application/json"
#$TMP/
cfn=$(echo "$1" |sed 's/\//_/g' )
export requestFileContentImage=$TMP/_request_raw$cfn.json
export responseFile=$TMP/response$cfn.json
export requestFile=$TMP/request$cfn.json

# echo "Response File: $responseFile"
# echo "Request File: $requestFile"

# Loads an ENV for the current host if exist
hostenvfile="_henv_$HOSTNAME.sh"
if [ -f $hostenvfile ]; then
    . ./$hostenvfile
#else
#    echo " ./$hostenvfile does not exist, create it if you require to define specific to platform variable or overwrite some."
fi
