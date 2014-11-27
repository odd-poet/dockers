
FROM oddpoet/centos6:jdk7
MAINTAINER Yunsang Choi <oddpoet@gmail.com>

#=======================
# Install zookeeper
#=======================
# ref : http://www.cloudera.com/content/cloudera-content/cloudera-docs/CDH5/latest/CDH5-Quick-Start/cdh5qs_yarn_pseudo.html
RUN curl http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/cloudera-cdh5.repo -o /etc/yum.repos.d/cloudera-cdh5.repo
RUN sed -i 's|cdh/5/|cdh/5.2.0/|' /etc/yum.repos.d/cloudera-cdh5.repo
RUN yum install -y zookeeper zookeeper-server
RUN yum clean all

#=======================
# Setup zookeeper
#=======================
RUN mkdir -p /var/lib/zookeeper
RUN chown -R zookeeper /var/lib/zookeeper/
RUN service zookeeper-server init

#=======================
# Start services.
#=======================
COPY start.sh start.sh
ENTRYPOINT ["/bin/bash", "start.sh"]
