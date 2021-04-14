#!/bin/sh
set -eux

BASE_LOG_PATH=/var/log/epics

export EPICS_IOC_LOG_FILE_NAME="${BASE_LOG_PATH}/${LOG_FILE_NAME}"

envsubst < ${EPICS_BASE}/logrotate.conf.tmplt > /etc/logrotate.conf
chmod 644 /etc/logrotate.conf

envsubst < ${EPICS_BASE}/crontab.tmplt > /etc/crontab
chmod 644 /etc/crontab

cron

${EPICS_BASE}/bin/${EPICS_HOST_ARCH}/iocLogServer
