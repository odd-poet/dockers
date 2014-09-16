
FROM centos:centos6
MAINTAINER Yunsang Choi <oddpoet@gmail.com>

#=======================
# Install JDK7 
#=======================
RUN yum clean all
RUN yum install wget sudo -y 
RUN wget --no-cookies --no-check-certificate --header "Cookie: gpw_e24=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/7u65-b17/jdk-7u65-linux-x64.rpm"
RUN rpm -ivh jdk-7u65-linux-x64.rpm
RUN rm jdk-7u65-linux-x64.rpm
RUN java -version 

#=======================
# Install CDH 5.1 + HBase
#=======================
# ref : http://www.cloudera.com/content/cloudera-content/cloudera-docs/CDH5/latest/CDH5-Quick-Start/cdh5qs_yarn_pseudo.html

RUN curl http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/cloudera-cdh5.repo -o /etc/yum.repos.d/cloudera-cdh5.repo

# modify to cdh5.1.0
RUN sed -i 's|cdh/5/|cdh/5.1.0/|' /etc/yum.repos.d/cloudera-cdh5.repo

# yum install
RUN yum install -y hadoop-conf-pseudo hbase hbase-master hbase-regionserver zookeeper zookeeper-server

#=======================
# Configure HBase pseduo-distributed
#=======================

COPY setup.sh setup.sh
COPY hbase-site.xml /etc/hbase/conf/hbase-site.xml 
COPY core-site.xml /etc/hadoop/conf/core-site.xml
RUN bash setup.sh

#=======================
# Start services.
#=======================
COPY start.sh start.sh
EXPOSE 50070 60010 60050 9090 2181
CMD ["/bin/bash", "start.sh"]


