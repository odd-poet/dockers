
FROM oddpoet/mesos
MAINTAINER Yunsang Choi <oddpoet@gmail.com>

#=======================
# Install chronos
#=======================
RUN yum install -y tar
WORKDIR /
RUN curl -sSfL http://downloads.mesosphere.io/chronos/chronos-2.1.0_mesos-0.14.0-rc4.tgz --output chronos.tgz
RUN tar xzf chronos.tgz

#=======================
# Start services.
#=======================
COPY start.sh start.sh
ENTRYPOINT ["/bin/bash", "start.sh"]
