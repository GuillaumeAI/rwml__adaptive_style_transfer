source _env.sh
featuretag=feat-timelining-21040614
featurebuildscript=dockers/$featuretag

echo "Building : $containertag"
echo " --Feature: $featuretag"
echo " ------ From:  $featurebuildscript"
echo "--------------------------------"
docker build -t $containertag-$featuretag $featurebuildscript

echo "DONE Building : $containertag"
echo " --Feature: $featuretag"

echo " ------ From:  $featurebuildscript"
echo "--------------------------------"
