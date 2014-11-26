
FROM centos:centos6
MAINTAINER Yunsang Choi <oddpoet@gmail.com>

#=======================
# Install utils
#=======================
COPY install-default.sh install-default.sh 
RUN ["/bin/bash", "install-default.sh"]


#=======================
# Install JDK7 
#=======================
COPY install-jdk7.sh install-jdk7.sh 
RUN ["/bin/bash", "install-jdk7.sh"]

#=======================
# Install mesos
#=======================
COPY install-mesos.sh install-mesos.sh
RUN ["/bin/bash", "install-mesos.sh"]


#=======================
# Start services.
#=======================
COPY start.sh start.sh
# mesos
EXPOSE 5050
ENTRYPOINT ["/bin/bash", "start.sh"]
