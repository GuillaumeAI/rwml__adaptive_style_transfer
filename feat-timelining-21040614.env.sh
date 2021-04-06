
# ??

source _env.sh

featuretag=feat-timelining-21040614


featurecontainertag=$containertag-$featuretag

featurebuildscript=dockers/$featuretag

export containertag=$featurecontainertag

