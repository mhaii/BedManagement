#!/usr/bin/env python

import os
import re
import sys


python = sys.executable
pip = os.path.join(os.path.dirname(python), ('Scripts/pip.exe' if os.name is 'nt' else
                                             ('pip3' if sys.platform == 'linux' else 'pip')))
rootDir = os.path.dirname(os.path.dirname(__file__))
manage = '%s %s' % (python, os.path.join(rootDir, 'manage.py'))
travis = 'TRAVIS' in os.environ

os.chdir(rootDir)

# fix $PATH for OSX
if os.name is not 'nt' and '/usr/local/bin' not in os.environ['PATH']:
    os.environ['PATH'] += ':/usr/local/bin'

############################################################################################################


def bower():
    os.system('%s bower install' % manage)


def collect_static():
    os.system('%s collectstatic --noinput --link -i %s' % (manage, ' -i '.join(['*.sass', '*.coffee'])))


def i18n():
    os.system('%s makemessages --all' % manage)
    os.system('%s compilemessages' % manage)


def import_fixture():
    regex = re.compile(r'\.(json|yaml)$')
    for dir in os.listdir(rootDir):
        path = os.path.join(rootDir, dir, 'fixtures')
        if os.path.isdir(path):
            os.system('%s loaddata %s' % (manage, ' '.join([file[:-5] for file in os.listdir(path)
                                                            if regex.search(file)])))


def init():
    if sys.platform == 'darwin':
        os.system('brew install %s' % (' '.join(['mysql', 'npm', 'gettext', 'msgpack'])))
        os.system('brew link gettext --force')
    elif sys.platform == 'linux':
        os.system('sudo apt-get install %s -y' % (' '.join(
                ['mysql-server', 'libmysqlclient-dev', 'nodejs', 'npm', 'gettext', 'libmsgpack*', 'python3-dev'])))
        if not os.path.isfile('/usr/bin/node'):
            os.system('sudo ln -s /usr/bin/nodejs /usr/bin/node')


def install_requirement():
    os.system('%s install -r %s' % (pip, os.path.join(rootDir, 'requirement.txt')))


def make_and_migrate():
    os.system('%s makemigrations' % manage)
    os.system('%s migrate' % manage)


def _mysql_cmd(sql):
    os.system('mysql -uroot -e "%s"' % sql)


def mysql_init():
    _mysql_cmd('create database bed_management')
    make_and_migrate()


def mysql_reset():
    _mysql_cmd('drop database bed_management')
    mysql_init()


def npm():
    print('Installing from npm')
    os.system('%snpm install -g %s' % ('sudo ' if not travis else '', ' '.join(['angular', 'bower', 'coffee'])))
