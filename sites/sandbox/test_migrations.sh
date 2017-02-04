#!/usr/bin/env bash
# 
# Test migrations run correctly with MySQL and Postgres

# Fail if any command fails
# http://stackoverflow.com/questions/90418/exit-shell-script-based-on-process-exit-code
set -e
set -o pipefail

if [ ! "$TRAVIS" == "true" ]
then
  # If not on Travis, then create databases
  echo "Creating MySQL database and user"
  mysql -u root -p -e "DROP DATABASE IF EXISTS oscar_travis; CREATE DATABASE oscar_travis"
  mysql -u root -p -e "GRANT ALL PRIVILEGES ON oscar_travis.* TO 'travis'@'localhost' IDENTIFIED BY '';"

fi

# MySQL
echo "Running migrations against MySQL"
./manage.py migrate --noinput --settings=settings_mysql

# Postgres
