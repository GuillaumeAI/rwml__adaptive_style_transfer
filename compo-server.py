#####################################################
# AST Composite Server
# By Guillaume Descoteaux-Isabelle, 20021
#
# This server compose two Adaptive Style Transfer model (output of the first pass serve as input to the second.)
########################################################
import os
import numpy as np
import tensorflow as tf
from module import encoder, decoder
from glob import glob
import runway


#from utils import *
import scipy
from datetime import datetime
import time


#set env var RW_ if not already set
if not os.getenv('RW_PORT'):
    os.environ["RW_PORT"] = "7860"

if not os.getenv('RW_DEBUG'):
    os.environ["RW_DEBUG"] = "0"
if not os.getenv('RW_HOST'):
    os.environ["RW_HOST"] = "0.0.0.0"
#RW_MODEL_OPTIONS
if not os.getenv('RW_MODEL_OPTIONS'):
    os.environ["RW_MODEL_OPTIONS"]='{"styleCheckpoint":"/data/styleCheckpoint"}'

# Determining the size of the passes
pass1_image_size = 1024
if not os.getenv('PASS1IMAGESIZE'):
   print("PASS1IMAGESIZE env var non existent;using default:" + pass1_image_size)
else:
   pass1_image_size = os.getenv('PASS1IMAGESIZE')
   print("PASS1IMAGESIZE value:" + pass1_image_size)

pass2_image_size = 2048
if not os.getenv('PASS2IMAGESIZE'):
   print("PASS12MAGESIZE env var non existent;using default:" + pass2_image_size)
else:
   pass2_image_size = os.getenv('PASS2IMAGESIZE')
   print("PASS2IMAGESIZE value:" + pass2_image_size)



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
    #Getting the model name
    model_name = [p for p in os.listdir(path) if os.path.isdir(os.path.join(path, p))][0]    
    if not os.getenv('MODELNAME'):
        dtprint("CONFIG::MODELNAME env var non existent;using default:" + model_name)
    else:
        model_name = os.getenv('MODELNAME')

    #Getting the model2 name
    model2_name = [p for p in os.listdir(path) if os.path.isdir(os.path.join(path, p))][1]
    if not os.getenv('MODELNAME'):
        dtprint("CONFIG::MODELNAME env var non existent;using default:" + model2_name)
    else:
        model2_name = os.getenv('MODEL2NAME')
        
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
    start = time.time()
    dtprint("Composing...")
    model = models.m1
    model2 = models.m2

    #
    img = inp['contentImage']
    img = np.array(img)
    img = img / 127.5 - 1.
    #@a Pass 1 RESIZE to 1024px the smaller side
    image_size=pass1_image_size
    img_shape = img.shape[:2]
    alpha = float(image_size) / float(min(img_shape))
    dtprint ("DEBUG::content.imgshape:" +   str(tuple(img_shape)) + ", alpha:" + str(alpha))

    img = scipy.misc.imresize(img, size=alpha)

    img = np.expand_dims(img, axis=0)
    #@a INFERENCE PASS 1
    dtprint("INFO:Pass1 inference starting")
    img = model['sess'].run(model['output_photo'], feed_dict={model['input_photo']: img})
    dtprint("INFO:Pass1 inference done")
    #
    img = (img + 1.) * 127.5
    img = img.astype('uint8')
    img = img[0]
    dtprint("INFO:Upresing Pass1 for Pass 2 (STARTING) ")

    #@a Pass 2 RESIZE to 2048px the smaller side
    image_size=pass2_image_size
    img_shape = img.shape[:2]
    
    
    alpha = float(image_size) / float(min(img_shape))
    dtprint ("DEBUG::pass1.imgshape:" +   str(tuple(img_shape)) + ", alpha:" + str(alpha))

    img = scipy.misc.imresize(img, size=alpha)
    dtprint("INFO:Upresing Pass1 (DONE) ")

    #Iteration 2    
    img = np.array(img)
    img = img / 127.5 - 1.
    img = np.expand_dims(img, axis=0)
    #@a INFERENCE PASS 2
    dtprint("INFO:Pass2 inference (STARTING)")
    img = model2['sess'].run(model2['output_photo'], feed_dict={model2['input_photo']: img})
    dtprint("INFO:Pass2 inference (DONE)")
    img = (img + 1.) * 127.5
    img = img.astype('uint8')
    img = img[0]

    dtprint("INFO:Composing done")
    stop = time.time()
    totaltime = stop - start
    print("The time of the run:", totaltime)
    res2 = dict(stylizedImage=img,totaltime=totaltime)
    return res2



def dtprint(msg):
    print getdttag() + "::" + msg  

def getdttag():
    # datetime object containing current date and time
    now = datetime.now()    

    # dd/mm/YY H:M:S
    # dt_string = now.strftime("%d/%m/%Y %H:%M:%S")
    return now.strftime("%H:%M:%S")

if __name__ == '__main__':
    #print('External Service port is:' +os.environ.get('SPORT'))
    runway.run()
