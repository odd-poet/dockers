#!/bin/bash 

service hadoop-hdfs-namenode start
service hadoop-hdfs-datanode start
service zookeeper-server start
service hbase-master start
service hbase-regionserver start


# infinite loop
while :; do echo "Running Hbase ..."; sleep 5; done
