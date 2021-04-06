source _env.sh

featuretag=feat-timelining-21040614
source $featuretag.env.sh

#featurecontainertag=$containertag-$featuretag

#featurebuildscript=dockers/$featuretag

echo "Building : $containertag"
echo " --Feature: $featuretag"
echo " ------ From:  $featurebuildscript"
echo "--------------------------------"
docker build -t $featurecontainertag $featurebuildscript

echo "DONE Building : $containertag"
echo " --Feature: $featuretag"

echo " ------ From:  $featurebuildscript"
echo "--------------------------------"
echo "-- Created Feature Containertag: "
echo "-------------------------------- $featurecontainertag "
echo " --- The containertag variable has been overridden--"
echo " ---- \$containertag=$containertag -----------------"

