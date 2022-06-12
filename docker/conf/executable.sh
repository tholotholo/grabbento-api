#!/bin/bash

# Start the first process
set -m

gunicorn -t 300 --worker-class=gevent --worker-connections=2048 --workers 4 --worker-tmp-dir /tmp/ --backlog 4096 --chdir /www/project project.wsgi:application --bind 0.0.0.0:8080 &
printenv | sed 's/^\(.*\)$/export \1/g' > /root/project_env.sh &
cron

fg %1