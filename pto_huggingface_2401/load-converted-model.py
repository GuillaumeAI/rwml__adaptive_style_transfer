#%% Imports
import tensorflow as tf
import logging

tf.get_logger().setLevel(logging.ERROR)

#%% 
export_dir = "/var/lib/ast/export/model_gia-young-picasso-v02b-201210-864_new-240ik/export2401261700"
model = tf.saved_model.load(export_dir)

# Use the loadded SavedModel to run inference on a test image.

#%% Image
sample_image="ellia_no_120__240123a.jpeg"
sample_image = tf.io.read_file(sample_image)
sample_image = tf.image.decode_jpeg(sample_image)
sample_image = tf.image.convert_image_dtype(sample_image, tf.float32)
sample_image = tf.image.resize(sample_image, [256, 256])
sample_image = tf.expand_dims(sample_image, 0)

#%% 
#output_image = model(sample_image)
#output_image = model.serve(tf.constant(sample_image))
out = model.
#%% 
#output_image = model.__call__(sample_image)
output_image = tf.squeeze(output_image, 0)
output_image = tf.clip_by_value(output_image, 0, 1)
output_image = tf.image.convert_image_dtype(output_image, tf.uint8)
output_image = tf.image.encode_jpeg(output_image)
tf.io.write_file("output_image.jpg", output_image)
print("Done")