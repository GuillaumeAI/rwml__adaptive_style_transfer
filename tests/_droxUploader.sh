#!/bin/bash
dp=/Downloads__2101/ast210505/seq_jgi__SC__210411_04
droxul mkdir $dp

#loop upload to dropbox
for i in {1..22};do for f in *jpg ; do sleep 333; droxul upload $f $dp;done ;sleep 1233;done

