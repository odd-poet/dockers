#!/bin/bash 

echo "============================="
echo " install CDH5+HBase"
echo "============================="

curl http://archive.cloudera.com/cdh5/redhat/6/x86_64/cdh/cloudera-cdh5.repo -o /etc/yum.repos.d/cloudera-cdh5.repo
sed -i 's|cdh/5/|cdh/5.2.0/|' /etc/yum.repos.d/cloudera-cdh5.repo
yum install -y hadoop-conf-pseudo hbase hbase-master hbase-regionserver zookeeper zookeeper-server

