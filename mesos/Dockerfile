
FROM oddpoet/centos6:jdk7
MAINTAINER Yunsang Choi <oddpoet@gmail.com>

#=======================
# Install mesos
#=======================
RUN rpm -Uvh http://repos.mesosphere.io/el/6/noarch/RPMS/mesosphere-el-repo-6-2.noarch.rpm
RUN yum install -y mesos
RUN yum clean all

#=======================
# Start services.
#=======================
COPY start.sh start.sh
ENTRYPOINT ["/bin/bash", "start.sh"]