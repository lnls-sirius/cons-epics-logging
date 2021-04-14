# Author: Cláudio Ferreira Carneiro
# LNLS - Brazilian Synchrotron Light Source Laboratory
FROM docker.io/lnlscon/epics-debian9-r3.15.8:2021-04-07
LABEL maintainer="Claudio Carneiro <claudio.carneiro@lnls.br>"

RUN apt-get update &&\
    apt-get install -y --fix-missing --no-install-recommends \
    cron\
    logrotate\
    && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /var/log/epics
WORKDIR ${EPICS_BASE}

COPY crontab.tmplt         ${EPICS_BASE}/crontab.tmplt
COPY logrotate.conf.tmplt  ${EPICS_BASE}/logrotate.conf.tmplt

COPY entrypoint.sh  /entrypoint.sh

# Default IOC log configuration
ENV LOG_FILE_NAME log
ENV EPICS_IOC_LOG_FILE_LIMIT 0
ENV EPICS_IOC_LOG_INET 0.0.0.0
ENV EPICS_IOC_LOG_PORT 7011

CMD [ "/bin/sh", "/entrypoint.sh"]

