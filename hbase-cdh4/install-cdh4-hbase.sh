#!/bin/sh

echo "============================="
echo " install CDH4+HBase"
echo "============================="

wget http://archive.cloudera.com/cdh4/one-click-install/redhat/6/x86_64/cloudera-cdh-4-0.x86_64.rpm
yum -y --nogpgcheck localinstall cloudera-cdh-4-0.x86_64.rpm
rpm --import http://archive.cloudera.com/cdh4/redhat/6/x86_64/cdh/RPM-GPG-KEY-cloudera 

yum install -y \
	hadoop-0.20-conf-pseudo \
	hbase hbase-master \ 
	hbase-regionserver \
	zookeeper zookeeper-server 

