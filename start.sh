#!/bin/sh
set -e

export POLEMARCH_SETTINGS_FILE=/data/conf/settings.ini

mkdir -p /data/conf /data/db /data/logs /data/cache /data/locks /data/projects /data/hooks

if [ ! -f $POLEMARCH_SETTINGS_FILE ]; then
  echo "${CONFIG} not found, creating..."
  cp /root/settings.ini.dist $POLEMARCH_SETTINGS_FILE
fi

/usr/local/bin/polemarchctl migrate

exec /usr/bin/supervisord -c /etc/supervisord.conf
