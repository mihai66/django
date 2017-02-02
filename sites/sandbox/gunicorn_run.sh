#!/bin/bash
set -e
SOCKFILE=/var/run/gunicorn.sock
LOGFILE=/home/apps/django-oscar/sites/sandbox/logs/gunicorn.log
LOGDIR=$(dirname $LOGFILE)
NUM_WORKERS=10
# user/group to run as
USER=apps
GROUP=apps
ADDRESS=127.0.0.1:8000
cd /home/apps/django-oscar/sites/sandbox/

if [ -f env.sh ]; then
    source env.sh
fi

source /home/apps/.virtualenvs/oscar/bin/activate
test -d $LOGDIR || mkdir -p $LOGDIR
exec exec /home/apps/./virtualenvs/oscar/bin/gunicorn wsgi:application -w $NUM_WORKERS --bind=$SOCKFILE \
  --user=$USER --group=$GROUP --log-level=info --timeout 60  \
  --log-file=$LOGFILE 2>>$LOGFILE
