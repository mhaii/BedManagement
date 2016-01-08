import os
import sys

python = sys.executable
pip = os.path.join(os.path.dirname(python), 'pip')
rootDir = os.path.dirname(os.path.dirname(__file__))
manage = os.path.join(rootDir, 'manage.py')

os.chdir(rootDir)


def collect_static():
    os.system('{0} {1} collectstatic --noinput -i *.sass -i *.coffee'.format(python, manage))


def install_requirement():
    os.system('{0} install -r {1}'.format(pip, os.path.join(rootDir, 'requirement.txt')))


def create_app():
    os.system('{0} {1} startapp {2}'.format(python, manage, input('New app name?: ')))
