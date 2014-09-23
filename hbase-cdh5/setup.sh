#!/bin/sh
echo "-----------------------------"
echo " Remove limit"
echo "-----------------------------"
# remove limit
# ref : https://github.com/ambling/hadoop-docker/commit/cd549b12fc939e12f8afe67cd9050f298e98a4b8
rm -f /etc/security/limits.d/hdfs.conf /etc/security/limits.d/mapreduce.conf /etc/security/limits.d/yarn.conf
rm -f /etc/security/limits.d/hbase.conf

echo "-----------------------------"
echo " Configuration HDFS"
echo "-----------------------------"
# step1: format
su hdfs -c "hdfs namenode -format"

# step2: start HDFS
for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do service $x stop ; done
for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do service $x start ; done

# step3: Create /tmp, Staging and Log Dir
su hdfs -c "hadoop fs -mkdir -p /tmp/hadoop-yarn/staging/history/done_intermediate"
su hdfs -c "hadoop fs -chown -R mapred:mapred /tmp/hadoop-yarn/staging"
su hdfs -c "hadoop fs -chmod -R 1777 /tmp "
su hdfs -c "hadoop fs -mkdir -p /var/log/hadoop-yarn"
su hdfs -c "hadoop fs -chown yarn:mapred /var/log/hadoop-yarn"


# step4: Verify the HDFS
su hdfs -c "hadoop fs -ls -R /"

echo "-----------------------------"
echo "Setup Zookeeper"
echo "-----------------------------"
mkdir -p /var/lib/zookeeper
chown -R zookeeper /var/lib/zookeeper/
service zookeeper-server init

echo "-----------------------------"
echo "Setup HBase"
echo "-----------------------------"

# stop service
service hbase-master stop
service hbase-regionserver stop

# create /hbase dir in HDFS
su hdfs -c "hadoop fs -mkdir /hbase"
su hdfs -c "hadoop fs -chown hbase /hbase"


echo "-----------------------------"
echo "Cleanup"
echo "-----------------------------"
for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do service $x stop ; done
service zookeeper-server stop
service hbase-master stop
service hbase-regionserver stop