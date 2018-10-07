#!/bin/bash

# install hadoop
cd /home/hadoop
tar -zxvf hbase-1.4.7-bin.tar.gz
ln -snf /home/hadoop/hbase-1.4.7 hbase-current
rm hbase-1.4.7-bin.tar.gz

mv /root/install/conf/hbase/conf/* /home/hadoop/hbase-current/conf/

chown -R hadoop:hadoop /home/hadoop/hbase*

sudo -u hadoop mkdir -p /data/conf/hbase
sudo -u hadoop mv /home/hadoop/hbase-current/conf /data/conf/hbase/
sudo -u hadoop cp /data/conf/hadoop/hdfs-site.xml /data/conf/hbase/conf/

JAVA_HOME='/usr/lib/jvm/java-1.8.0-openjdk-amd64'
HBASE_LOG_DIR='/home/hadoop/cluster_data/hbase/logs'
HBASE_PID_DIR='/home/hadoop/cluster_data/hbase/pids'

commands='
s/# export JAVA_HOME=.*/export JAVA_HOME='"${JAVA_HOME//\//\\\/}"'/
s/# export HBASE_LOG_DIR=.*/export HBASE_LOG_DIR='"${HBASE_LOG_DIR//\//\\\/}"'/
s/# export HBASE_PID_DIR=.*/export HBASE_PID_DIR='"${HBASE_PID_DIR//\//\\\/}"'/
'
sudo -u hadoop sed -i "${commands}" /data/conf/hbase/conf/hbase-env.sh

sudo -u hadoop ln -snf /data/conf/hbase/conf /home/hadoop/hbase-current/conf

# setup environment
hbase_path="/home/hadoop/hbase-current/bin"
sudo -u hadoop echo 'export PATH="'"${hbase_path}"':${PATH}"' >> /home/hadoop/.bash_profile
