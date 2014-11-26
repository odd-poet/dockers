#!/bin/sh

service hadoop-hdfs-datanode start
service hadoop-hdfs-namenode start 

service zookeeper-server start

service hbase-master start
service hbase-regionserver start

# infinite loop
while :; do sleep 5; done
