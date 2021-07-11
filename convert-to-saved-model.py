import os
import tensorflow as tf

trained_checkpoint_prefix = '/a/model/models/model_gia-ds-DavidBouchardGagnon-v02-210702-864x_new-240ik/checkpoint_long/model_gia-ds-DavidBouchardGagnon-v02-210702-864x_new_240000.ckpt-240000'
export_dir = os.path.join('/a/model/models/model_gia-ds-DavidBouchardGagnon-v02-210702-864x_new-240ik-savebd', '0')

graph = tf.Graph()
with tf.compat.v1.Session(graph=graph) as sess:
    # Restore from checkpoint
    loader = tf.compat.v1.train.import_meta_graph(trained_checkpoint_prefix + '.meta')
    loader.restore(sess, trained_checkpoint_prefix)

    # Export checkpoint to SavedModel
    builder = tf.compat.v1.saved_model.builder.SavedModelBuilder(export_dir)
    builder.add_meta_graph_and_variables(sess,
                                         [tf.saved_model.TRAINING, tf.saved_model.SERVING],
                                         strip_default_attrs=True)
    builder.save()     
