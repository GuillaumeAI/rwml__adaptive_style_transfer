#####################################################
# AST Composite Server Double Two
# By Guillaume Descoteaux-Isabelle, 20021
#
# This server compose two Adaptive Style Transfer model (output of the first pass serve as input to the second using the same model)
########################################################
#v1-dev
#Receive the 2 res from arguments in the request...


import os
import numpy as np
import tensorflow as tf
import cv2
from module import encoder, decoder
from glob import glob
import runway
from runway.data_types import number, text


#from utils import *
import scipy
from datetime import datetime
import time


import re


SRV_TYPE="s1"

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
pass1_image_size = 1328
if not os.getenv('PASS1IMAGESIZE'):
   print("PASS1IMAGESIZE env var non existent;using default:" + str(pass1_image_size)) 
else:
   pass1_image_size = os.getenv('PASS1IMAGESIZE', 1328)
   print("PASS1IMAGESIZE value:" + str(pass1_image_size))


# Determining the size of the passes
autoabc = 1
if not os.getenv('AUTOABC'):
   print("AUTOABC env var non existent;using default:")
   print(autoabc)
   abcdefault = 1
   print("NOTE----> when running docker, set   AUTOABC variable")
   print("   docker run ...  -e AUTOABC=1  #enabled, 0 to disabled (default)")
else:
   autoabc = os.getenv('AUTOABC',1)
   print("AUTOABC value:")
   print(autoabc)
   abcdefault = autoabc


#pass2_image_size = 1024
#if not os.getenv('PASS2IMAGESIZE'):
#   print("PASS2IMAGESIZE env var non existent;using default:" + pass2_image_size)
#else:
#   pass2_image_size = os.getenv('PASS2IMAGESIZE')
#   print("PASS2IMAGESIZE value:" + pass2_image_size)

# pass3_image_size = 2048
# if not os.getenv('PASS3IMAGESIZE'):
#    print("PASS3IMAGESIZE env var non existent;using default:" + pass3_image_size)
# else:
#    pass3_image_size = os.getenv('PASS3IMAGESIZE')
#    print("PASS3IMAGESIZE value:" + pass3_image_size)

##########################################
##   MODELS
#model name for sending it in the response
model1name = "UNNAMED"
if not os.getenv('MODEL1NAME'):
   print("MODEL1NAME env var non existent;using default:" + model1name)
else:
   model1name = os.getenv('MODEL1NAME', "UNNAMED")
   print("MODEL1NAME value:" + model1name)
   
# #m2
# model2name = "UNNAMED"
# if not os.getenv('MODEL2NAME'):   print("MODEL2NAME env var non existent;using default:" + model2name)
# else:
#    model2name = os.getenv('MODEL2NAME')
#    print("MODEL2NAME value:" + model2name)

# #m3
# model3name = "UNNAMED"
# if not os.getenv('MODEL3NAME'):   print("MODEL3NAME env var non existent;using default:" + model3name)
# else:
#    model3name = os.getenv('MODEL3NAME')
#    print("MODEL3NAME value:" + model3name)

#######################################################

def get_model_simplified_name_from_dirname(dirname):
    result_simple_name = dirname.replace("model_","").replace("_864x","").replace("_864","").replace("_new","").replace("-864","")
    print("   result_simple_name:" + result_simple_name)
    return result_simple_name

def get_padded_checkpoint_no_from_filename(checkpoint_filename):
    match = re.search(r'ckpt-(\d+)', checkpoint_filename)
    if match:
      number = int(match.group(1))
    checkpoint_number = round(number/1000,0)
    print(checkpoint_number)

    padded_checkpoint_number = str(str(checkpoint_number).zfill(3))
    return padded_checkpoint_number.replace('.0','')

found_model='none'
found_model_checkpoint='0'

#########################################################
# SETUP


runway_files = runway.file(is_directory=True)
@runway.setup(options={'styleCheckpoint': runway_files})
def setup(opts):
    global found_model,found_model_checkpoint
    sess = tf.Session()
    # sess2 = tf.Session()
    # sess3 = tf.Session()
    init_op = tf.global_variables_initializer()
    # init_op2 = tf.global_variables_initializer()
    # init_op3 = tf.global_variables_initializer()
    sess.run(init_op)
    # sess2.run(init_op2)
    # sess3.run(init_op3)
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
    # saver2 = tf.train.Saver()
    # saver3 = tf.train.Saver()
    print("-------------====PATH---------------------->>>>--")
    path_default = '/data/styleCheckpoint'
    print("opts:")
    print(opts)
    print("----------------------------------------")
    if opts is None:
        print("ERROR:opts is None")
        path = path_default
    try:
        path = opts['styleCheckpoint']
    except:
        opts= {'styleCheckpoint': u'/data/styleCheckpoint'}
        path = opts['styleCheckpoint']
    if not os.path.exists(path):
        print("ERROR:Path does not exist:" + path)
        path = path_default
    print(path)
    print("----------------PATH=======---------------<<<<--")
    #Getting the model name
    model_name = [p for p in os.listdir(path) if os.path.isdir(os.path.join(path, p))][0]    
    if not os.getenv('MODELNAME'):
        dtprint("CONFIG::MODELNAME env var non existent;using default:" + model_name)
    else:
        model_name = os.getenv('MODELNAME')
    
    

    # #Getting the model2 name
    # model2_name = [p for p in os.listdir(path) if os.path.isdir(os.path.join(path, p))][1]
    # if not os.getenv('MODEL2NAME'):
    #     dtprint("CONFIG::MODEL2NAME env var non existent;using default:" + model2_name)
    # else:
    #     model2_name = os.getenv('MODEL2NAME')
        

    ##Getting the model3 name
    # model3_name = [p for p in os.listdir(path) if os.path.isdir(os.path.join(path, p))][2]
    # if not os.getenv('MODEL3NAME'):
    #     dtprint("CONFIG::MODEL3NAME env var non existent;using default:" + model3_name)
    # else:
    #     model3_name = os.getenv('MODEL3NAME')
    
    

    checkpoint_dir = os.path.join(path, model_name, 'checkpoint_long')
    #checkpoint2_dir = os.path.join(path, model2_name, 'checkpoint_long')
    # checkpoint3_dir = os.path.join(path, model3_name, 'checkpoint_long')
    print("-----------------------------------------")
    print("modelname is : " + model_name)
    
    found_model=get_model_simplified_name_from_dirname(model_name)
    
    #print("model2name is : " + model2_name)
    # print("model3name is : " + model3_name)
    print("checkpoint_dir is : " + checkpoint_dir)

    

    
    #print("checkpoint2_dir is : " + checkpoint2_dir)
    # print("checkpoint3_dir is : " + checkpoint3_dir)
    print("-----------------------------------------")
    ckpt = tf.train.get_checkpoint_state(checkpoint_dir)
    #ckpt2 = tf.train.get_checkpoint_state(checkpoint2_dir)
    # ckpt3 = tf.train.get_checkpoint_state(checkpoint3_dir)
    ckpt_name = os.path.basename(ckpt.model_checkpoint_path)
    
    found_model_checkpoint= get_padded_checkpoint_no_from_filename(ckpt_name)
    
    #ckpt2_name = os.path.basename(ckpt2.model_checkpoint_path)
    # ckpt3_name = os.path.basename(ckpt3.model_checkpoint_path)
    saver.restore(sess, os.path.join(checkpoint_dir, ckpt_name))
    #saver2.restore(sess2, os.path.join(checkpoint2_dir, ckpt2_name))
    # saver3.restore(sess3, os.path.join(checkpoint3_dir, ckpt3_name))
    m1 = dict(sess=sess, input_photo=input_photo, output_photo=output_photo)
    #m2 = dict(sess=sess2, input_photo=input_photo, output_photo=output_photo)
    # m3 = dict(sess=sess3, input_photo=input_photo, output_photo=output_photo)
    models = type('', (), {})()
    models.m1 = m1
    #models.m2 = m2
    # models.m3 = m3
    return models



def make_target_output_filename(  mname,checkpoint, fn='',res1=0,abc=0, ext='.jpg',svrtype="s1", modelid='', suffix='', xtra_model_id='',verbose=False):
    fn_base=fn.replace(ext,"")
    fn_base=fn_base.replace(".jpg","")
    fn_base=fn_base.replace(".jpeg","")
    fn_base=fn_base.replace(".JPG","")
    fn_base=fn_base.replace(".JPEG","")
    fn_base=fn_base.replace(".png","")
    fn_base=fn_base.replace(".PNG","")
    
    #pad res1 and res2 to 4 digits
    res1_pad=str(res1).zfill(4)
    
    abc_pad=str(abc).zfill(2)
    if res1_pad=="0000":
        res1_pad=""
        
    
    #pad checkpoint to 3 digits
    checkpoint=checkpoint.zfill(3)
    
    if fn_base=="none":
        fn_base=""
    
    if '/' in fn_base:
        fn_base=fn_base.split('/')[-1]
    # Print out all input info:
    if verbose  :
            
        print("-----------------------------")
        print("fn_base: ",fn_base)
        print("mname: ",mname)
        print("suffix: ",suffix)
        print("res1: ",res1_pad)
        print("abc: ",abc_pad)
        print("ext: ",ext)
        print("svrtype: ",svrtype)
        print("modelid: ",modelid)
        print("xtra_model_id: ",xtra_model_id)
        print("checkpoint: ",checkpoint)
        print("fn: ",fn)
    
    mtag = "{}__{}__{}x{}__{}__{}k".format(mname,suffix,res1_pad,abc_pad, svrtype, checkpoint).replace("_0x" + str(abc_pad), "")
    if verbose:
        print(mtag)
    target_output = "{}__{}__{}{}{}".format(fn_base, modelid, mtag, xtra_model_id, ext).replace("_"+str(abc_pad)+"x"+str(abc_pad)+"_","").replace("_0x0_", "").replace("_0_", "").replace("_-", "_").replace("____", "__").replace("___", "__").replace("___", "__").replace("..",".").replace("model_","").replace("_x"+str(abc_pad)+"_","").replace("gia-ds-","")
    target_output = replace_values_from_csv(target_output)

    return target_output

def replace_values_from_csv(target_output):
    # Implement the logic to replace values from CSV
    #load replacer.csv and replace the values (src,dst)
    src_dest_file = 'replacer.csv'
    if os.path.exists(src_dest_file):
        with open(src_dest_file, 'r') as file:
            lines = file.readlines()
            for line in lines:
                src, dst = line.split(',')
                target_output = target_output.replace(src, dst)
    return target_output.replace("\n", "").replace("\r", "").replace(" ", "_")
    

def _make_meta_as_json(x1=0,c1=0,inp=None,result_dict=None):
    global found_model,found_model_checkpoint
    fn='none'
    if inp['fn'] != 'none':
        fn=inp['fn']
    ext='.jpg'
    if inp['ext'] != '.jpg':
        ext=inp['ext']
    
    filename=make_target_output_filename(found_model,found_model_checkpoint,fn,x1,c1,ext,SRV_TYPE)
    
    if result_dict is None:
        json_return = {
            "model": str(found_model),
            "checkpoint": str(found_model_checkpoint),
            "filename": str(filename)
        }
        return json_return
    else: #support adding to the existing dict the data directly
        result_dict['model']=str(found_model)
        result_dict['checkpoint']=str(found_model_checkpoint)
        result_dict['filename']=str(filename)
        return result_dict
    


meta_inputs={'meta':text}
meta_outputs={'model':text,'filename':text,'checkpoint':text}

@runway.command('meta2', inputs=meta_inputs, outputs=meta_outputs)
def get_geta(models, inp):
    global found_model,found_model_checkpoint
    
    json_return = _make_meta_as_json()
        # "files": "nothing yet"
    print(json_return)
    return json_return 



@runway.command('meta', inputs=meta_inputs, outputs=meta_outputs)
def get_geta(models, inp):
    global found_model,found_model_checkpoint
    
    json_return = _make_meta_as_json(inp)
        # "files": "nothing yet"
    print(json_return)
    return json_return 




#@STCGoal add number or text to specify resolution of the three pass
inputs={'contentImage': runway.image,'x1':number(default=1024,min=24,max=8000),'c1':number(default=0,min=-99,max=99),'fn':text(default='none'),'ext':text(default='.jpg')}
outputs={'stylizedImage': runway.image,'totaltime':number,'x1': number,'c1':number,'model1name':text,'checkpoint':text,'filename':text,'model':text}

@runway.command('stylize', inputs=inputs, outputs=outputs)
def stylize(models, inp):
    global found_model,found_model_checkpoint,model1name
    start = time.time()
    
    model = models.m1
    #model2 = models.m2
    # model3 = models.m3
    
    #Getting our names back (even though I think we dont need)
    #@STCIssue BUGGED
    # m1name=models.m1.name
    # m2name=models.m2.name
    # m3name=models.m3.name

    #get size from inputs rather than env
    x1 = int(inp['x1'])
    
    c1 = int(inp['c1'])

    #
    img = inp['contentImage']
    img = np.array(img)
    img = img / 127.5 - 1.

    #@a Pass 1 RESIZE to 1368px the smaller side
    image_size=pass1_image_size
    image_size=x1
    img_shape = img.shape[:2]
    alpha = float(image_size) / float(min(img_shape))
    #dtprint ("DEBUG::content.imgshape:" +   str(tuple(img_shape)) + ", alpha:" + str(alpha))

    try:
        img = scipy.misc.imresize(img, size=alpha)
    except:
        pass
        

    img = np.expand_dims(img, axis=0)
    #@a INFERENCE PASS 1
    dtprint("INFO:Pass1 inference starting")
    img = model['sess'].run(model['output_photo'], feed_dict={model['input_photo']: img})
    
    #
    img = (img + 1.) * 127.5
    img = img.astype('uint8')
    img = img[0]
    #dtprint("INFO:Upresing Pass1 for Pass 2 (STARTING) ")

    #@a Pass 2 RESIZE to 1024px the smaller side
    #image_size=pass2_image_size
    #image_size=x2
    #img_shape = img.shape[:2]
    
    
    #alpha = float(image_size) / float(min(img_shape))
    #dtprint ("DEBUG::pass1.imgshape:" +   str(tuple(img_shape)) + ", alpha:" + str(alpha))

    #img = scipy.misc.imresize(img, size=alpha)
    #dtprint("INFO:Upresing Pass1 (DONE) ")

    #Iteration 2    
    #img = np.array(img)
    #img = img / 127.5 - 1.
    #img = np.expand_dims(img, axis=0)
    #@a INFERENCE PASS 2 using the same model
    #dtprint("INFO:Pass2 inference (STARTING)")
    #img = model['sess'].run(model['output_photo'], feed_dict={model['input_photo']: img})
    #dtprint("INFO:Pass2 inference (DONE)")
    #img = (img + 1.) * 127.5
    #img = img.astype('uint8')
    #img = img[0]



    # #pass3

    # #@a Pass 3 RESIZE to 2048px the smaller side
    # image_size=pass3_image_size
    # image_size=x3
    # img_shape = img.shape[:2]
    
    
    # alpha = float(image_size) / float(min(img_shape))
    # dtprint ("DEBUG::pass2.imgshape:" +   str(tuple(img_shape)) + ", alpha:" + str(alpha))

    # img = scipy.misc.imresize(img, size=alpha)
    # dtprint("INFO:Upresing Pass2 (DONE) ")

    # #Iteration 3
    # img = np.array(img)
    # img = img / 127.5 - 1.
    # img = np.expand_dims(img, axis=0)
    # #@a INFERENCE PASS 3
    # dtprint("INFO:Pass3 inference (STARTING)")
    # img = model3['sess'].run(model3['output_photo'], feed_dict={model3['input_photo']: img})
    # dtprint("INFO:Pass3 inference (DONE)")
    # img = (img + 1.) * 127.5
    # img = img.astype('uint8')
    # img = img[0]
    # #pass3

    #dtprint("INFO:Composing done")

    if c1 != 0 :
        print('Auto Brightening images...' + str(c1))
        img = img, alpha2, beta = automatic_brightness_and_contrast(img,c1)

    stop = time.time()
    totaltime = stop - start
    print("The time of the run:", totaltime)
    
    #if model1name UNNAMED, use found_model
    if model1name == "UNNAMED":
        model1name=found_model
    
    include_meta_directly_in_result=True
    
    
    if include_meta_directly_in_result:
        result_dict = dict(stylizedImage=img,totaltime=totaltime,x1=x1,model1name=model1name,c1=c1)
        result_dict = _make_meta_as_json(x1,c1,inp,result_dict)
    else:
        meta_data = _make_meta_as_json(x1,c1,inp)
        result_dict = dict(stylizedImage=img,totaltime=totaltime,x1=x1,model1name=model1name,c1=c1,meta=meta_data)
        
    return result_dict



def dtprint(msg):
    dttag=getdttag()
    print(dttag + "::" + msg  )

def getdttag():
    # datetime object containing current date and time
    now = datetime.now()    

    # dd/mm/YY H:M:S
    # dt_string = now.strftime("%d/%m/%Y %H:%M:%S")
    return now.strftime("%H:%M:%S")



# Automatic brightness and contrast optimization with optional histogram clipping
def automatic_brightness_and_contrast(image, clip_hist_percent=25):
    gray = cv2.cvtColor(image, cv2.COLOR_BGR2GRAY)

    # Calculate grayscale histogram
    hist = cv2.calcHist([gray],[0],None,[256],[0,256])
    hist_size = len(hist)

    # Calculate cumulative distribution from the histogram
    accumulator = []
    accumulator.append(float(hist[0]))
    for index in range(1, hist_size):
        accumulator.append(accumulator[index -1] + float(hist[index]))

    # Locate points to clip
    maximum = accumulator[-1]
    clip_hist_percent *= (maximum/100.0)
    clip_hist_percent /= 2.0

    # Locate left cut
    minimum_gray = 0
    while accumulator[minimum_gray] < clip_hist_percent:
        minimum_gray += 1

    # Locate right cut
    maximum_gray = hist_size -1
    while accumulator[maximum_gray] >= (maximum - clip_hist_percent):
        maximum_gray -= 1

    # Calculate alpha and beta values
    alpha = 255 / (maximum_gray - minimum_gray)
    beta = -minimum_gray * alpha

    '''
    # Calculate new histogram with desired range and show histogram 
    new_hist = cv2.calcHist([gray],[0],None,[256],[minimum_gray,maximum_gray])
    plt.plot(hist)
    plt.plot(new_hist)
    plt.xlim([0,256])
    plt.show()
    '''

    auto_result = cv2.convertScaleAbs(image, alpha=alpha, beta=beta)
    return (auto_result, alpha, beta)


if __name__ == '__main__':
    #print('External Service port is:' +os.environ.get('SPORT'))    
    os.environ["RW_PORT"] = "7860"
    print("Launched...")
    runway.run()
