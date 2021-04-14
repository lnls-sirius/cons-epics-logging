# sirius-epics-logging
EPICS remote logging service.

## Default IOC log configuration
ENV LOG_FILE_NAME log
ENV EPICS_IOC_LOG_FILE_LIMIT 0
ENV EPICS_IOC_LOG_INET 0.0.0.0
ENV EPICS_IOC_LOG_PORT 7011

The logfile is rotated using `logrotate` and `cron`.

```yaml
version: '3.7'
services:
  caputlog:
    image: dockerregistry.lnls-sirius.com.br/gco/epics-logging:2021-04-14-65563cb
    networks:
      - host_network
    volumes:
      - "<...>:/var/log/epics:rw"
    environment:
      - "LOG_FILE_NAME=my-log-file-name"
      - "EPICS_IOC_LOG_FILE_LIMIT=0"
      - "EPICS_IOC_LOG_INET=0.0.0.0"
      - "EPICS_IOC_LOG_PORT=7012"

networks:
  host_network:
    external:
      name: "host"
```