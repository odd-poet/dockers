#!/bin/sh

PORT=${1:-2181}

echo "Starting zookeeper "
echo " - port : $PORT"

sed -i -r "s|clientPort=[0-9]+|clientPort=$PORT|" /etc/zookeeper/conf/zoo.cfg

service zookeeper-server start

# infinite loop
while :; do sleep 5; done
