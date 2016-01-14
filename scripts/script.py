#!/usr/bin/python

import os
import re
import sys

python = sys.executable
pip = os.path.join(os.path.dirname(python), 'pip' + ('.exe' if os.name is 'nt' else ''))
rootDir = os.path.dirname(os.path.dirname(__file__))
manage = os.path.join(rootDir, 'manage.py')

os.chdir(rootDir)

# fix $PATH for OSX
if os.name is 'nt':
    print('# Executing on Windows')
else:
    print('# Executing on Unix')
    if '/usr/local/bin' in os.environ['PATH']:
        print('# PATH is fine')
    else:
        print('# PATH is fucked')
        os.environ['PATH'] += ':/usr/local/bin'


def bower():
    os.system('npm install -g bower')
    os.system('bower install')


def collect_static():
    os.system('{0} {1} collectstatic --noinput -i {2}'.format(python, manage, ' -i '.join(['*.sass', '*.coffee'])))


def create_app():
    os.system('{0} {1} startapp {2}'.format(python, manage, input('New app name?: ')))


def flush_db():
    os.system('{0} {1} flush --no-input'.format(python, manage))


def import_fixture():
    regex = re.compile(r'\.(json|yaml)$')
    for file in os.listdir(rootDir):
        path = os.path.join(rootDir, file, 'fixtures')
        if os.path.isdir(path):
            [os.system('{0} {1} loaddata {2}'.format(python, manage, fixture[:-5])) for fixture in os.listdir(path) if regex.search(fixture)]


def install_requirement():
    os.system('{0} install -r {1}'.format(pip, os.path.join(rootDir, 'requirement.txt')))


def make_and_migrate():
    os.system('{0} {1} makemigrations'.format(python, manage))
    os.system('{0} {1} migrate'.format(python, manage))


def init():
    pass

