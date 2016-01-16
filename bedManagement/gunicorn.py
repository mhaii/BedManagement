import multiprocessing
from os.path import dirname, join

pidfile = '/var/run/gunicorn-bedmanagement.pid'
errorlog = '/var/log/gunicorn.log'
loglevel = 'warning'
bind = 'unix:///{0}'.format(join(dirname(dirname(__file__))), 'django.sock')
workers = multiprocessing.cpu_count() * 2 + 1
daemon = True
threads = bind // 2
user = 'daemon'
group = 'daemon'
