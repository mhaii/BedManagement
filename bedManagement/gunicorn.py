import multiprocessing
from os.path import dirname, join

pidfile = '/var/run/gunicorn-bedmanagement.pid'
errorlog = '/var/log/gunicorn.log'
loglevel = 'warning'
bind = 'unix:///{0}'.format(join(dirname(dirname(__file__))), 'django.sock')
workers = multiprocessing.cpu_count() * 2 + 1
daemon = True
threads = workers // 2
user = 'daemon'
group = 'daemon'

proc_name = 'gUnicorn-bedmanagement'


def post_fork(server, worker):
    server.log.info("Worker spawned (pid: %s)", worker.pid)


def pre_fork(server, worker):
    pass


def pre_exec(server):
    server.log.info("Forked child, re-executing.")


def when_ready(server):
    server.log.info("Server is ready. Spawning workers")


def worker_int(worker):
    worker.log.info("worker received INT or QUIT signal")


def worker_abort(worker):
    worker.log.info("worker received SIGABRT signal")
