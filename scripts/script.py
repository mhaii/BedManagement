#!/usr/bin/env python

import os
import re
import sys

python = sys.executable
pip = os.path.join(os.path.dirname(python), ('Scripts/pip.exe' if os.name is 'nt' else ('pip3' if sys.platform == 'linux' else 'pip')))
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


def collect_static():
    os.system('{0} {1} bower install'.format(python, manage))
    os.system('{0} {1} collectstatic --noinput --link -i {2}'.format(python, manage, ' -i '.join(['*.sass', '*.coffee'])))


def create_app():
    os.system('{0} {1} startapp {2}'.format(python, manage, input('New app name?: ')))


def flush_db():
    os.system('{0} {1} flush --no-input'.format(python, manage))


def i18n():
    os.system('{0} {1} makemessages --all'.format(python, manage))
    os.system('{0} {1} compilemessages'.format(python, manage))


def import_fixture():
    regex = re.compile(r'\.(json|yaml)$')
    for file in os.listdir(rootDir):
        path = os.path.join(rootDir, file, 'fixtures')
        if os.path.isdir(path):
            [os.system('{0} {1} loaddata {2}'.format(python, manage, fixture[:-5])) for fixture in os.listdir(path) if regex.search(fixture)]


def init():
    if sys.platform == 'darwin':
        [os.system('brew install {0}'.format(drink)) for drink in ['mysql', 'npm', 'gettext', 'msgpack']]
        os.system('brew link gettext --force')
    elif sys.platform == 'linux':
        [os.system('sudo apt-get install {0} -y'.format(stuff)) for stuff in ['mysql-server', 'libmysqlclient-dev', 'nodejs', 'npm', 'gettext', 'libmsgpack*', 'python3-dev']]
        if not os.path.isfile('/usr/bin/node'):
            os.system('sudo ln -s /usr/bin/nodejs /usr/bin/node')


def install_requirement():
    os.system('{0} install -r {1}'.format(pip, os.path.join(rootDir, 'requirement.txt')))


def make_and_migrate():
    os.system('{0} {1} makemigrations'.format(python, manage))
    os.system('{0} {1} migrate'.format(python, manage))


def module():
    [os.system('sudo npm install -g {0}'.format(module)) for module in ['angular', 'bower', 'coffee']]
