#!/bin/bash

appdir="/var/www/bed_management/current"
dir=$(dirname $appdir)"/shared"
app="gunicorn"
pidfile=$dir/$app".pid"

do_start () {
	# Assuming this is on root directory of project
	daemon=true
	log=$dir/$app".log"
	loglevel="warning"
	bind="unix://"$dir/$app".sock"
	workers=$(python -c 'import multiprocessing; print(multiprocessing.cpu_count() * 2 + 1)')
	user='deploy'
	group='deploy'
	umask=664

	args=" bedManagement.wsgi"
	args+=" -m "$umask
	if [ -v daemon ] && [ $daemon = true ]; then args+=" --daemon";	fi
	if [ -v pidfile ]; 	then args+=" --pid "$pidfile; 				fi
	if [ -v log ]; 		then args+=" --log-file "$log; 				fi
	if [ -v loglevel ]; then args+=" --log-level "$loglevel; 		fi
	if [ -v bind ]; 	then args+=" --bind "$bind; 				fi
	if [ -v workers ]; 	then args+=" --workers "$workers; 			fi
	if [ -v user ]; 	then args+=" --user "$user; 				fi
	if [ -v group ]; 	then args+=" --group "$group; 				fi

	echo "Argument:"$args
	sudo $app$args
}

start_server () {
	if [ -f $pidfile ]; then
		pid=$(cat $pidfile)
		if [ $(ps -p $pid | wc -l) -gt 1 ]; then
			echo "Server is already running!"
			return
		fi
		rm -f $pidfile
	fi
	cd $appdir
	echo "Starting server!"
	do_start
}

stop_server () {
	if [ -f $pidfile ]; then
		pid=$(cat $pidfile)
		if [ $(ps -p $pid | wc -l) -gt 1 ]; then
			echo "Stopping server"
			sudo kill -9 $pid
			return
		fi
		echo "Stale PID file"
		rm -f $pidfile
	else
		echo "PID file not found"
	fi
	echo "Server not running"
}

status () {
	if [ -f $pidfile ]; then
		pid=$(cat $pidfile)
		if [ $(ps -p $pid | wc -l) -gt 1 ]; then
			echo "Server is running"
			return
		fi
		echo "Stale PID file"
		rm -f $pidfile
	fi
	echo "Server not running"
}

case $1 in
'start')
	start_server
	;;
'stop')
	stop_server
	;;
'restart')
	stop_server
	sleep 2
	start_server
	;;
*)
	echo "Usage: $0 { start | stop | restart | status}"
	;;
esac

exit 0
