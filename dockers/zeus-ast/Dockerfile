#---This in the Dockerfile
#-----#singleonev1devcontainertag
#-----guillaumeai/server:ast-210606-singleone-v1-dev
FROM guillaumeai/server:ast-210606-singleone-v1-dev
#MODEL1NAME=model_gia-ds-dbginko-v03-210809-864x_new
#mkdir $modelmountpoint
WORKDIR /data/styleCheckpoint/model_gia-ds-dbginko-v03-210809-864x_new/checkpoint_long
COPY /a/model/models/model_gia-ds-dbginko-v03-210809-864x_new/checkpoint_long/model_gia-ds-dbginko-v03-210809-864x_new_300000.ckpt-300000.meta /data/styleCheckpoint/model_gia-ds-dbginko-v03-210809-864x_new/checkpoint_long/model_gia-ds-dbginko-v03-210809-864x_new_300000.ckpt-300000.meta #COPY $modellocalpointmeta $modelmountpointmeta
COPY /a/model/models/model_gia-ds-dbginko-v03-210809-864x_new/checkpoint_long/model_gia-ds-dbginko-v03-210809-864x_new_300000.ckpt-300000.index /data/styleCheckpoint/model_gia-ds-dbginko-v03-210809-864x_new/checkpoint_long/model_gia-ds-dbginko-v03-210809-864x_new_300000.ckpt-300000.index #COPY $modellocalpointindex $modelmountpointindex
COPY /a/model/models/model_gia-ds-dbginko-v03-210809-864x_new/checkpoint_long/model_gia-ds-dbginko-v03-210809-864x_new_300000.ckpt-300000.data-00000-of-00001:/data/styleCheckpoint/model_gia-ds-dbginko-v03-210809-864x_new/checkpoint_long/model_gia-ds-dbginko-v03-210809-864x_new_300000.ckpt-300000.data-00000-of-00001 #COPY $modellocalpointdata:$modelmountpointdata     
COPY /tmp/astiatmp/model_gia-ds-dbginko-v03-210809-864x_new_checkpoint_300:/data/styleCheckpoint/model_gia-ds-dbginko-v03-210809-864x_new/checkpoint_long/checkpoint #COPY $mcheckpointfilepath:$modelmountpointckfile