#!/bin/bash 
echo "-----------------------------"
echo " Config ulimit"
echo "-----------------------------"

echo "hdfs  -       nofile  32768" >> /etc/security/limits.conf
echo "hbase -       nofile  32768" >> /etc/security/limits.conf
rm /etc/security/limits.d/hbase.conf
rm /etc/security/limits.d/hdfs.conf
rm /etc/security/limits.d/mapred.conf

echo "-----------------------------"
echo " Setup HDFS"
echo "-----------------------------"

# step1 : format
su - hdfs -c "hdfs namenode -format"

# step2 : start hdfs
for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do service $x start ; done

# Step 3: Create the /tmp Directory
su - hdfs -c "hadoop fs -mkdir /tmp"
su - hdfs -c "hadoop fs -chmod -R 1777 /tmp"

# Step 4: Create the MapReduce system directories:
su - hdfs -c "hadoop fs -mkdir -p /var/lib/hadoop-hdfs/cache/mapred/mapred/staging"
su - hdfs -c "hadoop fs -chmod 1777 /var/lib/hadoop-hdfs/cache/mapred/mapred/staging"
su - hdfs -c "hadoop fs -chown -R mapred /var/lib/hadoop-hdfs/cache/mapred"

# Step 5: Verify the HDFS File Structure
su - hdfs -c "hadoop fs -ls -R /"

echo "-----------------------------"
echo " Setup Hbase"
echo "-----------------------------"
service zookeeper-server init
su - hdfs -c "hadoop fs -mkdir /hbase" 
su - hdfs -c "hadoop fs -chown hbase /hbase" 

echo "-----------------------------"
echo " Cleanup"
echo "-----------------------------"
for x in `cd /etc/init.d ; ls hadoop-hdfs-*` ; do service $x stop ; done
service zookeeper-server stop
service hbase-master stop
service hbase-regionserver stop