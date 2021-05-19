
# ========================= INFERENCE PARAMETERS ========================= #
parser.add_argument('--ii_dir',
                    dest='inference_images_dir',
                    type=parse_list,
                    default=['./data/sample_photographs/'],
                    help='Directory with images we want to process.')
parser.add_argument('--save_dir',
                    type=str,
                    default=None,
                    help='Directory to save inference output images.'
                         'If not specified will save in the model directory.')
parser.add_argument('--ckpt_nmbr',
                    dest='ckpt_nmbr',
                    type=int,
                    default=None,
                    help='Checkpoint number we want to use for inference. '
                         'Might be None(unspecified), then the latest available will be used.')
