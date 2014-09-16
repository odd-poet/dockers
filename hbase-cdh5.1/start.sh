#!/bin/sh

#for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do service $x start ; done
#service hadoop-yarn-resourcemanager start
#service hadoop-yarn-nodemanager start
#service hadoop-mapreduce-historyserver start

service hadoop-hdfs-datanode start
service hadoop-hdfs-namenode start 

service zookeeper-server start

service hbase-master start
service hbase-regionserver start

