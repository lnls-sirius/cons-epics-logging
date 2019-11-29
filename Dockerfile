# Author: Cláudio Ferreira Carneiro
# LNLS - Brazilian Synchrotron Light Source Laboratory

FROM debian:buster-slim
LABEL maintainer="Claudio Carneiro <claudio.carneiro@lnls.br>"

# Timezone
ENV DEBIAN_FRONTEND noninteractive
ENV TZ=America/Sao_Paulo

# CONS data repo
ENV CONS_IP 10.0.38.42
ENV CONS_REPO http://${CONS_IP}:20081/download

# IOC operation variables
ENV EPICS_VERSION R3.15.6
ENV ARCH linux-x86_64
ENV EPICS_HOST_ARCH linux-x86_64
ENV EPICS_CA_AUTO_ADDR_LIST YES
ENV EPICS_BASE /opt/epics-${EPICS_VERSION}/base

# Pyepics libca location
ENV PYEPICS_LIBCA ${EPICS_BASE}/lib/${ARCH}/libca.so

ENV PATH ${EPICS_BASE}/bin/${ARCH}:/opt/procServ:${PATH}

RUN apt-get update &&\
    apt-get install -y --fix-missing --no-install-recommends \
        telnet logrotate build-essential libpcre3-dev wget tzdata \
        git libreadline-gplv2-dev && rm -rf /var/lib/apt/lists/* && \
    dpkg-reconfigure --frontend noninteractive tzdata

COPY logrotate.conf     /etc/logrotate.conf
RUN  chmod 644          /etc/logrotate.conf

RUN mkdir -p /opt/epics-${EPICS_VERSION} && mkdir -p /var/log/epics
WORKDIR /opt/epics-${EPICS_VERSION}

# Epics Base
RUN wget -O /opt/epics-R3.15.6/base-3.15.6.tar.gz ${CONS_REPO}/EPICS/base-3.15.6.tar.gz && \
    cd /opt/epics-R3.15.6 && tar -xvzf base-3.15.6.tar.gz && rm base-3.15.6.tar.gz &&\
    mv base-3.15.6 base && cd base && make -j 32

# Default IOC log configuration
ENV EPICS_IOC_LOG_FILE_NAME /var/log/epics/caput.log
ENV EPICS_IOC_LOG_FILE_LIMIT 0
ENV EPICS_IOC_LOG_INET 0.0.0.0
ENV EPICS_IOC_LOG_PORT 7011

CMD /opt/epics-R3.15.6/base/bin/linux-x86_64/iocLogServer