import tensorflow as tf
saved_model_dir='/a/model/models/model_gia-ds-DavidBouchardGagnon-v02-210702-864x_new-240ik/checkpoint_long'

converter = tf.lite.TFLiteConverter.from_saved_model(saved_model_dir)
converter.optimizations = [tf.lite.Optimize.DEFAULT]
tflite_quant_model = converter.convert()
