
FROM centos:centos6
MAINTAINER Yunsang Choi <oddpoet@gmail.com>

#=======================
# Install utils
#=======================
RUN yum clean all
RUN yum install -y curl wget tar telnet 

#=======================
# Install JDK7 
#=======================
COPY install-jdk7.sh install-jdk7.sh
RUN bash install-jdk7.sh

RUN echo "# set JAVA_HOME"  >> ~/.bashrc 
RUN echo "export JAVA_HOME=/usr/java/default" >> ~/.bashrc 
RUN echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc
