"""
#########################################################
#########################################################
########### Fabric doesn't support Python 3.x ###########
########### So this file (and only this file) ###########
########### must be written in Python 2.x :(( ###########
################ This is sad, I know.... ################
#########################################################
#########################################################
"""

from fabric.api import local, settings, abort, run, cd, env, sudo

import os
import sys

# Configurations
APP_NAME = 'django'
APP_DIR = '/var/www/bedmanagement/%s' % APP_NAME
REPO_URL = 'git@github.com:mhaii/BedManagement.git'

env.key_filename = ['~/.ssh/id_rsa.pub']
env.host_string = '%s@bed.mhaii.xyz' % os.environ['USER']


def _prepare():
    pass


def _pre_deploy(branch):
    if branch == 'master':
        if raw_input('Enter CONFIRM to continue: ') != 'CONFIRM':
            sys.exit(0)


def deploy(branch='master'):
    _pre_deploy(branch)
    with settings(warn_only=True):
        if run('test -d %s' % APP_DIR).failed:
            run('git clone %s --branch %s %s' % (REPO_URL, branch, APP_DIR))
    with cd(APP_DIR):
        # reset any manual changes to the remote files
        run('git reset --hard')
        # pull updates from github
        run('git pull')
        _post_deploy()


def deploy_clean(branch='master'):
    _pre_deploy(branch)
    with settings(warn_only=True):
        sudo('rm -rf %s' % APP_DIR)
        deploy(branch)


def _post_deploy():
    sudo('python3 scripts/install_requirement.py')
    sudo('pip3 install gunicorn')
    run('bower install')
    run('python3 scripts/collect_static.py')
    run('python3 scripts/make_and_migrate.py')
    run('python3 scripts/import_fixture.py')
    run('python3 scripts/i18n.py')
    gunicorn('restart')


def gunicorn(args='restart'):
    run('%s/gunicorn.sh %s' % (APP_DIR, args))
