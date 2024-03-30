import tempfile
import tarfile
import re
import wget
import os
import sys
import zipfile
import subprocess


URL_REGEX = re.compile(
        r'^(?:http|ftp)s?://' # http:// or https://
        r'(?:(?:[A-Z0-9](?:[A-Z0-9-]{0,61}[A-Z0-9])?\.)+(?:[A-Z]{2,6}\.?|[A-Z0-9-]{2,}\.?)|' #domain...
        r'localhost|' #localhost...
        r'\d{1,3}\.\d{1,3}\.\d{1,3}\.\d{1,3})' # ...or ip
        r'(?::\d+)?' # optional port
        r'(?:/?|[/?]\S+)$', re.IGNORECASE)


def is_url(path):
    return re.match(URL_REGEX, path)


def download_to_temp_dir(url):
    print('Downloading file: %s' % url)
    tmp_path = tempfile.mkdtemp()
    fname = wget.download(url)
    if fname.endswith('.tar.gz'):
        tar = tarfile.open(fname, "r:gz")
        tar.extractall(path=tmp_path)
        tar.close()
    elif fname.endswith('.tar'):
        tar = tarfile.open(fname, "r")
        tar.extractall(path=tmp_path)
        tar.close()
    elif fname.endswith('.zip'):
        zip_ref = zipfile.ZipFile(fname, 'r')
        zip_ref.extractall(tmp_path)
        zip_ref.close()
    os.remove(fname)
    contents = os.listdir(tmp_path)
    if len(contents) == 1 and os.path.isdir(os.path.join(tmp_path, contents[0])):
        return os.path.join(tmp_path, contents[0])
    return tmp_path


def run_command(cmd, verbose=True):
    cmd_with_env = "test -f ~/.bash_profile && source ~/.bash_profile; PYTHONUNBUFFERED=1 %s" % cmd
    process = subprocess.Popen(['bash', '-c', cmd_with_env], stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    if verbose:
        for line in process.stdout:
            sys.stdout.write(line.decode('utf8'))
            sys.stdout.flush()
    out, _ = process.communicate()
    return process, out
