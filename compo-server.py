import os
import numpy as np
import tensorflow as tf
from module import encoder, decoder
from glob import glob
import runway


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
    ckpt_name = os.path.basename(ckpt.model_checkpoint_path)
    saver.restore(sess, os.path.join(checkpoint_dir, ckpt_name))
    m1 = dict(sess=sess, input_photo=input_photo, output_photo=output_photo)
    return m1


@runway.command('stylize', inputs={'contentImage': runway.image}, outputs={'stylizedImage': runway.image})
def stylize(model, inp):
    img = inp['contentImage']
    img = np.array(img)
    img = img / 127.5 - 1.
    img = np.expand_dims(img, axis=0)
    img = model.m1['sess'].run(model.m1['output_photo'], feed_dict={model.m1['input_photo']: img})
    img = (img + 1.) * 127.5
    img = img.astype('uint8')
    img = img[0]
    return dict(stylizedImage=img)


if __name__ == '__main__':
    print('External Service port is:' +os.environ.get('SPORT'))
    runway.run()
