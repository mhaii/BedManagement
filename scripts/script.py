import os
import sys

from os.path import join

python = sys.executable
pip = join(os.path.dirname(python), 'pip')
rootdir = os.path.dirname(os.path.dirname(__file__))


def collect_static():
    os.system('{0} {1} collectstatic --noinput -i *.sass -i *.coffee'.format(python, join(rootdir, 'manage.py')))


def install_requirement():
    os.system('{0} install -r {1}'.format(pip, join(rootdir, 'requirement.txt')))
