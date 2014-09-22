
FROM centos:centos6
MAINTAINER Yunsang Choi <oddpoet@gmail.com>

#=======================
# Install JDK6 
#=======================
RUN yum clean all
RUN yum install wget sudo -y 
RUN wget --no-cookies --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" http://download.oracle.com/otn-pub/java/jdk/6u45-b06/jdk-6u45-linux-x64-rpm.bin --no-check-certificate -O ./jdk-6u45-linux-x64-rpm.bin
RUN chmod +x jdk-6u45-linux-x64-rpm.bin
RUN ./jdk-6u45-linux-x64-rpm.bin
RUN rm jdk-6u45-linux-x64-rpm.bin
RUN rm sun*.rpm
RUN rm jdk*.rpm

RUN echo "export JAVA_HOME=/usr/java/default" >> ~/.bashrc 
RUN echo "export PATH=\$PATH:\$JAVA_HOME/bin" >> ~/.bashrc

RUN java -version 


#=======================
# Install CDH 4.2
#=======================
# ref : http://www.cloudera.com/content/cloudera-content/cloudera-docs/CDH4/4.2.0/CDH4-Quick-Start/cdh4qs_topic_3_2.html


RUN wget http://archive.cloudera.com/cdh4/one-click-install/redhat/6/x86_64/cloudera-cdh-4-0.x86_64.rpm
RUN yum -y --nogpgcheck localinstall cloudera-cdh-4-0.x86_64.rpm
RUN rpm --import http://archive.cloudera.com/cdh4/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera 

RUN yum install -y hadoop-0.20-conf-pseudo

#=======================
# Configure HBase pseduo-distributed
#=======================

#COPY setup.sh setup.sh
#COPY hbase-site.xml /etc/hbase/conf/hbase-site.xml 
#COPY core-site.xml /etc/hadoop/conf/core-site.xml
#RUN bash setup.sh

#=======================
# Start services.
#=======================
#COPY start.sh start.sh
#EXPOSE 50070 60010 60050 9090 2181
#CMD ["/bin/bash", "start.sh"]


