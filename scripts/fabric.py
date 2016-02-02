#!/usr/bin/env python
import os
import sys


def fabric():
    if sys.version_info[0] != 2:
        print('This must be run with python 2 only!')
        return
    os.system('sudo easy_install pip')
    os.system('pip install fabric')

fabric()
