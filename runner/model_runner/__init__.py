import argparse
import glob
import os
import sys
import yaml
from model_runner.utils import is_url, download_to_temp_dir, run_command

parser = argparse.ArgumentParser("Runway Model Runner")
parser.add_argument('model_path', help='Path or URL with model source')
parser.add_argument('--run', action='store_true', help='Run model without building')
parser.add_argument('--build', action='store_true', help='Build model without running')
parser.add_argument('--meta', action='store_true', help='Show model options and commands')
parser.add_argument('--host', type=str, default='0.0.0.0', help='Host for the model server')
parser.add_argument('--port', type=int, default=8000, help='Port for the model server')
parser.add_argument('--rw_model_options', type=str, help='Pass options to the Runway model as a JSON string')

args = parser.parse_args()

if is_url(args.model_path):
    path = download_to_temp_dir(args.model_path)
else:
    path = args.model_path

os.chdir(path)

def error(msg):
    print('ERROR: %s' % msg)
    sys.exit(1)

if 'runway.yml' not in glob.glob('*'):
    error('No runway.yml found')

try:
    spec = yaml.safe_load(open('runway.yml'))
except Exception as e:
    error('Could not load runway.yml')

def build():
    print('Building...')

    build_steps = []

    if 'framework' in spec:
        if spec['framework'] == 'tensorflow':
            build_steps.append('pip install tensorflow==1.15')
        elif spec['framework'] == 'pytorch':
            build_steps.append('pip install torch==1.5.0')

    if 'build_steps' in spec:
        build_steps.extend(spec['build_steps'])

    # Clear cache after user-defined build steps to reduce image size
    build_steps.extend([
        'rm -rf ~/.cache/pip/*',
        'rm -rf /var/lib/apt/lists/*'
    ])

    for build_step in build_steps:
        if type(build_step) == dict and 'if_gpu' in build_step:
            if os.getenv('GPU') == '1':
                build_step = build_step['if_gpu']
            else:
                continue
        if type(build_step) == dict and 'if_cpu' in build_step:
            if os.getenv('GPU') != '1':
                build_step = build_step['if_cpu']
            else:
                continue
        print('')
        print('Running build step: ' + build_step)
        print('')
        process, out = run_command(build_step)
        if process.returncode != 0:
            print('Command failed: "%s"' % build_step)
            print(out.decode('utf8').strip())
            error('Build failed')

    print('Build steps completed')

if not args.run:
    build()

if args.build:
    sys.exit(0)

sys.path.insert(1, path)

entrypoint = spec['entrypoint']

if args.meta:
    run_command('RW_META=1 ' + entrypoint)
    sys.exit(0)

run_command(entrypoint)
