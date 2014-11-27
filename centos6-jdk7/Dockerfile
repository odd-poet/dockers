
FROM centos:centos6
MAINTAINER Yunsang Choi <oddpoet@gmail.com>

ENV JDK_RPM jdk-7u71-linux-x64.rpm

#=======================
# Install utils
#=======================
RUN yum clean all
RUN yum install -y curl wget tar telnet 

#=======================
# Install JDK7 
#=======================
COPY ${JDK_RPM} ${JDK_RPM}
RUN rpm -ivh ${JDK_RPM}
RUN echo "# set JAVA_HOME"  >> ~/.bashrc 
RUN echo "export JAVA_HOME=/usr/java/default" >> ~/.bashrc 
RUN echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc
