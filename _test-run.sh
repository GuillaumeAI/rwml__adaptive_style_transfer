

docker run -it --rm --name compo_ast_dbg_v01b_90_90_60_dev -v /a/src/rwml__adaptive_style_transfer:/work -v /a/model/models/model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-90ik/checkpoint_long:/data/styleCheckpoint/model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-90ik/checkpoint_long -v /a/model/models/model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-90ik_/checkpoint_long:/data/styleCheckpoint/model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-90ik_/checkpoint_long -v /a/model/models/model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-60ik/checkpoint_long:/data/styleCheckpoint/model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-60ik/checkpoint_long -p 9099:8000 -e PASS1IMAGESIZE=640 -e PASS2IMAGESIZE=768 -e PASS3IMAGESIZE=1538 -e MODELNAME=model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-90ik_ -e MODEL2NAME=model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-90ik -e MODEL3NAME=model_gia-ds-DavidBouchardGagnon-v01b-210510-864_new-60ik -e SPORT=9099 -v /a/bin:/a/bin -v /home/jgi/.dropbox_uploader:/root/.dropbox_uploader -v /home/jgi:/config guillaumeai/server:ast-210502-compo-three-v2-dev
