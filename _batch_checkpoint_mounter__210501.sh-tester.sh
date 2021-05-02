
# Test the installed services

if [ "$1" == "" ]; then
	echo "Must specify a file"
	exit 1
fi

mkdir -p tests
cd tests

#s=./custom-cli-start-script-docker-dev-specific-checkpoint.210430.sh 

m=model_gia-ds-fpolsonwill_v02_210424_new
export chks_long_all="15 30 45 60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300"
export partial_210108="60 75 90 105 120 135 150 165 180 195 210 225 240 255 270 285 300"



export chks=$chks_long_all
export chks=$partial_210108


#$s model_gia-ds-fpolsonwill_v02_210424_new 9092 225
#$s model_gia-ds-fpolsonwill_v02_210424_new 9093 240

startport=9070
for c in $chks
do
	echo "------------------------------------------------------------"
	echo "Testing Webapi installed for "
	echo "- Model     : $m  "
	echo "- checkpoint: $c "
	echo "- on port   : $startport"
	echo "gia-ast $1 $startport"

	startport=$( expr $startport + 1 )
done

echo "file should have been genenated in ./tests"
cd ..


