#/usr/bin/python
import multiprocessing
import os
from os.path import abspath, dirname, join

dir = dirname(dirname(dirname(abspath(__file__))))

pidfile = join(dir, 'gunicorn.pid')
errorlog = join(dir, 'gunicorn.log')
loglevel = 'warning'
bind = 'unix://%s' % join(dir, 'gunicorn.sock')
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


if __name__ == '__main__':
    if os.path.isfile(pidfile):
        pid = open(pidfile, 'r').readline().strip()
    def start():
        if os.path.isfile(pidfile):
            if os.system('ps -p %s > /dev/null' % pid):
                os.remove(pidfile)
            else:
                print('Server is already running!')
                return
        path = dirname(abspath(__file__))
        os.chdir(path)
        print('Currently on %s' % os.getcwd())
        dir = os.path.basename(dirname(__file__))
        os.system('gunicorn -c %s/%s %s.wsgi' % (dir, os.path.basename(__file__), dir))

    def stop():
        if os.path.isfile(pidfile):
            if not os.system('ps -p %s > /dev/null' % pid):
                print('Stopping server')
                os.system('sudo -9 %s' % pid)
            else:
                print('Server not running')
            os.remove(pidfile)
        else:
            print('No PID file found')

    def restart():
        from time import sleep
        stop()
        sleep(3)
        start()

    import sys
    if len(sys.argv) == 2:
        if sys.argv[1] == 'start':
            start()
        elif sys.argv[1] == 'stop':
            stop()
        elif sys.argv[1] == 'restart':
            restart()
        else:
            print('Invalid command')
    else:
        print('Usage: { start | stop | restart }')