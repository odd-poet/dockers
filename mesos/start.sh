#!/bin/sh

declare ZK=$1

if [[ "$1" == "" ]];then 
	echo "Need zookeeper info. (e.g. zk://localhost:2181/mesos)"
	exit 1
fi

echo "config zookeeper info"
echo "$ZK" > /etc/mesos/zk

echo "Starting mesos..."
mesos-init-wrapper slave &
mesos-init-wrapper master 


