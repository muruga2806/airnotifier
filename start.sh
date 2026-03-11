#!/bin/sh
set -e

export LOGDIR=/var/log/airnotifier
export LOGFILE=$LOGDIR/airnotifier.log
export LOGFILE_ERR=$LOGDIR/airnotifier.err

if [ ! -f "./config.py" ]; then
  cp config.py-sample config.py
fi

sed -i 's/https = True/https = False/g' ./config.py

if [ ! -f "./logging.ini" ]; then
  cp logging.ini-sample logging.ini
fi

mkdir -p $LOGDIR

touch "$LOGFILE"
touch "$LOGFILE_ERR"

echo "Installing AirNotifier ..."
pipenv run ./install.py

echo "Starting AirNotifier on port ${PORT:-10000} ..."
pipenv run ./app.py --port=${PORT:-10000}
