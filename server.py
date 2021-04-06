import os
import numpy as np
import tensorflow as tf
from module import encoder, decoder
from glob import glob
import runway
# import cv2

@runway.setup(options={'styleCheckpoint': runway.file(is_directory=True)})
def setup(opts):
    sess = tf.Session()
    init_op = tf.global_variables_initializer()
    sess.run(init_op)
    with tf.name_scope('placeholder'):
        input_photo = tf.placeholder(dtype=tf.float32,
                                     shape=[1, None, None, 3],
                                     name='photo')
    input_photo_features = encoder(image=input_photo,
                                   options={'gf_dim': 32},
                                   reuse=False)
    output_photo = decoder(features=input_photo_features,
                           options={'gf_dim': 32},
                           reuse=False)
    saver = tf.train.Saver()
    path = opts['styleCheckpoint']
    model_name = [p for p in os.listdir(path) if os.path.isdir(os.path.join(path, p))][0]
    checkpoint_dir = os.path.join(path, model_name, 'checkpoint_long')
    ckpt = tf.train.get_checkpoint_state(checkpoint_dir)
    ckpt_name = os.path.basename(ckpt.model_checkpoint_path)
    saver.restore(sess, os.path.join(checkpoint_dir, ckpt_name))
    return dict(sess=sess, input_photo=input_photo, output_photo=output_photo)


@runway.command('stylize', inputs={'contentImage': runway.image}, outputs={'stylizedImage': runway.image})
def stylize(model, inp):
    contentImage = inp['contentImage']
    data=help(contentImage)
   
    contentImage = np.array(contentImage)
    contentImage = contentImage / 127.5 - 1.
    contentImage = np.expand_dims(contentImage, axis=0)
    stylizedImage = model['sess'].run(model['output_photo'], feed_dict={model['input_photo']: contentImage})
    stylizedImage = (stylizedImage + 1.) * 127.5
    stylizedImageuint8 = stylizedImage.astype('uint8')
    stylizedImage = stylizedImage.astype('uint8')
    stylizedImage = stylizedImage[0]
    result = dict(stylizedImage=stylizedImage)
    #@STCGoal A Sequencing of result is being saved
    savedir='/work/build'

    dataFile='/work/build/data.txt'
    d = open(dataFile, "w")
    d.write(data)
    d.close()
    
    
    
    contentFile='/work/build/content.jpg'
    c = open(contentFile, "w")
    c.write(contentImage)
    c.close()

# we dont get what we want here...
    # metafile='/work/build/meta.txt'
    # m = open(metafile,"a+")
    # m.write('type:contentImage')
    # m.write(type(contentImage))
    # m.write('type:stylizedImage')
    # m.write(type(stylizedImage))
    # m.close()

    stylizedFile='/work/build/stylized.jpg'
    s = open(stylizedFile, "w")
    s.write(stylizedImage)
    s.close()
    
    return result



if __name__ == '__main__':
    print('External Service port is:' +os.environ.get('SPORT'))
    runway.run()
