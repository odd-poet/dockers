#!/bin/sh

ZK=$1

if [[ "$ZK" == "" ]]; then 
	echo "you should set zookeeper quorum."
	exit 1
fi

sed -i -r "s|#ZOOKEEPER#|$ZK|" /etc/hbase/conf/hbase-site.xml 

echo "Start hadoop..."
for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do 
	service $x start &
done

echo "Start master & regionserver"
service hbase-master start &
service hbase-regionserver start &

# infinite loop
while :; do sleep 5; done
