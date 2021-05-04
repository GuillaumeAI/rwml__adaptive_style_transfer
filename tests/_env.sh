export crpf=mycrop
export dropbox_root_dir=/lib/results/compo-three-v2-dev
export infile=mycrop.jpg
export out_ext=jpg
export cropscript=_crop.sh
export outdir_prefix='ohcrop_'
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

export requestFileContentImage=_request_raw$1.json
export responseFile=response$1.json
export requestFile=sample-args$1.json


# Loads an ENV for the current host if exist
hostenvfile="_henv_$HOSTNAME.sh"
if [ -f $hostenvfile ]; then
    . ./$hostenvfile
else
    echo " ./$hostenvfile does not exist, create it if you require to define specific to platform variable or overwrite some."
fi