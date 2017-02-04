#!/bin/bash

NAME="oscar"                                  # Name of the application
PIDFILE=/home/apps/django/gunicorn.pid
DJANGODIR=/home/apps/django/sites/sandbox             # Django project directory
SOCKFILE=/home/apps/django/sites/sandbox/gunicorn.sock  # we will communicte using this unix socket
USER=apps                                        # the user to run as
GROUP=apps
ADDRESS=127.0.0.1:8000                                     # the group to run as
NUM_WORKERS=10                                     # how many worker processes should Gunicorn spawn
DJANGO_SETTINGS_MODULE=settings             # which settings file should Django use
DJANGO_WSGI_MODULE=wsgi                     # WSGI module name

echo "Starting $NAME as `whoami`"

# Activate the virtual environment
cd $DJANGODIR
source  /home/apps/.virtualenvs/oscar/bin/activate
export DJANGO_SETTINGS_MODULE=$DJANGO_SETTINGS_MODULE
export PYTHONPATH=$DJANGODIR:$PYTHONPATH

# Create the run directory if it doesn't exist
RUNDIR=$(dirname $SOCKFILE)
test -d $RUNDIR || mkdir -p $RUNDIR

# Start your Django Unicorn
# Programs meant to be run under supervisor should not daemonize themselves (do not use --daemon)
exec  /home/apps/.virtualenvs/oscar/bin/gunicorn ${DJANGO_WSGI_MODULE}:application \
  --name $NAME \
  --workers $NUM_WORKERS \
  --user=$USER --group=$GROUP \
  --bind=$ADDRESS \
  --pid $PIDFILE \
  --log-level=debug \
  --log-file=/home/apps/django/sites/sandbox/gunicorn.log
