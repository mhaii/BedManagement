import multiprocessing
from os.path import dirname, join

dir = dirname(dirname(__file__))

pidfile = join(dir, 'gunicorn.pid')
errorlog = join(dir, 'gunicorn.log')
loglevel = 'warning'
bind = 'unix:///{0}'.format(join(dir, 'django.sock'))
workers = multiprocessing.cpu_count() * 2 + 1
daemon = True
threads = workers // 2
user = 'daemon'
group = 'daemon'

proc_name = 'gunicorn-bedmanagement'


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
