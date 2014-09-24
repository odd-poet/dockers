
FROM centos:centos6
MAINTAINER Yunsang Choi <oddpoet@gmail.com>

#=======================
# Install utils
#=======================
COPY install-default.sh install-default.sh 
RUN ["/bin/bash", "install-default.sh"]

#=======================
# Install JDK6
#=======================
COPY install-jdk6.sh install-jdk6.sh 
RUN ["/bin/bash", "install-jdk6.sh"]

#=======================
# Install CDH 4
#=======================
# ref : http://www.cloudera.com/content/cloudera-content/cloudera-docs/CDH4/4.2.0/CDH4-Quick-Start/cdh4qs_topic_3_2.html

COPY install-cdh4-hbase.sh install-cdh4-hbase.sh
RUN ["/bin/bash", "install-cdh4-hbase.sh"]

#=======================
# Setup 
#=======================
COPY hbase-site.xml /etc/hbase/conf/hbase-site.xml
COPY core-site.xml /etc/hadoop/conf/core-site.xml
COPY setup.sh setup.sh
RUN bash setup.sh 

#=======================
# Start services.
#=======================
COPY start.sh start.sh
# zookeeper
EXPOSE 2181
# HBase master
EXPOSE 65000
# HBase master web UI
EXPOSE 65010
# HBase regionserver
EXPOSE 65020
# HBase regionserver web UI
EXPOSE 65030
CMD ["/bin/bash", "start.sh"]


