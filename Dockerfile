# LICENSE UPL 1.0
#
# Copyright (c) 2014, 2020 Oracle and/or its affiliates.
#
#
# Container image template for Oracle Instant Client
#
# REQUIRED FILES TO BUILD THIS IMAGE
# ==================================
# 
# From http://www.oracle.com/technetwork/topics/linuxx86-64soft-092277.html
#  Download the following three RPMs:
#    - oracle-instantclient12.2-basic-12.2.0.1.0-1.x86_64.rpm
#    - oracle-instantclient12.2-devel-12.2.0.1.0-1.x86_64.rpm
#    - oracle-instantclient12.2-sqlplus-12.2.0.1.0-1.x86_64.rpm 
#
# HOW TO BUILD THIS IMAGE
# -----------------------
# Put all downloaded files in the same directory as this Dockerfile
# Run: 
#      $ docker build --pull -t oracle/instantclient:12.2.0.1 .
#
#
FROM oraclelinux:7-slim

ADD 12clibs/oracle-instantclient*.rpm /tmp/

RUN  yum -y install /tmp/oracle-instantclient*.rpm && \
     rm -rf /var/cache/yum && \
     rm -f /tmp/oracle-instantclient*.rpm && \
     echo /usr/lib/oracle/12.2/client64/lib > /etc/ld.so.conf.d/oracle-instantclient12.2.conf && \
     ldconfig

ENV PATH=$PATH:/usr/lib/oracle/12.2/client64/bin

ENV PKG_CONFIG_PATH=$PKG_CONFIG_PATH:/usr/lib64/pkgconfig
ADD 12clibs/oci8.pc /usr/lib64/pkgconfig/
RUN yum -y install git
RUN yum -y install gcc
RUN yum -y install tar

EXPOSE 8080

#CMD ["sqlplus", "-v"]
CMD bash

