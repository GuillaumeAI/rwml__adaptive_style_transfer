import os
import numpy as np
import tensorflow as tf
from module import encoder, decoder
from glob import glob
import runway


@runway.setup(options={'styleCheckpoint': runway.file(is_directory=True)})
def setup(opts):
    sess = tf.Session()
    sess2 = tf.Session()
    init_op = tf.global_variables_initializer()
    init_op2 = tf.global_variables_initializer()
    sess.run(init_op)
    sess2.run(init_op2)
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
    saver2 = tf.train.Saver()
    path = opts['styleCheckpoint']
    model_name = [p for p in os.listdir(path) if os.path.isdir(os.path.join(path, p))][0]
    model2_name = [p for p in os.listdir(path) if os.path.isdir(os.path.join(path, p))][1]
    checkpoint_dir = os.path.join(path, model_name, 'checkpoint_long')
    checkpoint2_dir = os.path.join(path, model2_name, 'checkpoint_long')
    print("-----------------------------------------")
    print("modelname is : " + model_name)
    print("model2name is : " + model2_name)
    print("checkpoint_dir is : " + checkpoint_dir)
    print("checkpoint2_dir is : " + checkpoint2_dir)
    print("-----------------------------------------")
    ckpt = tf.train.get_checkpoint_state(checkpoint_dir)
    ckpt2 = tf.train.get_checkpoint_state(checkpoint2_dir)
    ckpt_name = os.path.basename(ckpt.model_checkpoint_path)
    ckpt2_name = os.path.basename(ckpt2.model_checkpoint_path)
    saver.restore(sess, os.path.join(checkpoint_dir, ckpt_name))
    saver2.restore(sess2, os.path.join(checkpoint2_dir, ckpt2_name))
    m1 = dict(sess=sess, input_photo=input_photo, output_photo=output_photo)
    m2 = dict(sess=sess2, input_photo=input_photo, output_photo=output_photo)
    models = type('', (), {})()
    models.m1 = m1
    models.m2 = m2
    return models


@runway.command('stylize', inputs={'contentImage': runway.image}, outputs={'stylizedImage': runway.image})
def stylize(models, inp):
    model = models.m1
    model2 = models.m2

    #
    img = inp['contentImage']
    img = np.array(img)
    img = img / 127.5 - 1.
    img = np.expand_dims(img, axis=0)
    img = model['sess'].run(model['output_photo'], feed_dict={model['input_photo']: img})
    img = (img + 1.) * 127.5
    img = img.astype('uint8')
    img = img[0]



    res1 = dict(stylizedImage=img)

    
    #
    img2 = res1['stylizedImage']
    img2 = np.array(img2)
    img2 = img2 / 127.5 - 1.
    img2 = np.expand_dims(img2, axis=0)
    img2 = model2['sess'].run(model2['output_photo'], feed_dict={model2['input_photo']: img2})
    img2 = (img2 + 1.) * 127.5
    img2 = img2.astype('uint8')
    img2 = img2[0]

    res2 = dict(stylizedImage=img2)

    return res2


if __name__ == '__main__':
    print('External Service port is:' +os.environ.get('SPORT'))
    runway.run()
