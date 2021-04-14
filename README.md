# sirius-epics-logging
EPICS remote logging service.

## Default IOC log configuration
ENV LOG_FILE_NAME log
ENV EPICS_IOC_LOG_FILE_LIMIT 0
ENV EPICS_IOC_LOG_INET 0.0.0.0
ENV EPICS_IOC_LOG_PORT 7011

The logfile is rotated using `logrotate` and `cron`.

