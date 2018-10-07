#!/bin/bash

# install hadoop
cd /home/hadoop
tar -zxvf hadoop-2.9.1.tar.gz
ln -snf /home/hadoop/hadoop-2.9.1 hadoop-current
rm hadoop-2.9.1.tar.gz

mv /root/install/conf/hadoop/* /home/hadoop/hadoop-current/etc/hadoop/

mkdir -p /home/hadoop/setup
mv /root/install/setup-hadoop.sh /home/hadoop/setup/

chown -R hadoop:hadoop /home/hadoop

sudo -u hadoop mkdir -p /data/conf
sudo -u hadoop mv /home/hadoop/hadoop-current/etc/hadoop /data/conf/

JAVA_HOME='/usr/lib/jvm/java-1.8.0-openjdk-amd64'
HADOOP_LOG_DIR='/home/hadoop/cluster_data/logs'
HADOOP_PID_DIR='/home/hadoop/cluster_data/pids'

commands='
s/${JAVA_HOME}/'"${JAVA_HOME//\//\\\/}"'/
s/#export HADOOP_LOG_DIR=${HADOOP_LOG_DIR}\/$USER/export HADOOP_LOG_DIR='"${HADOOP_LOG_DIR//\//\\\/}"'/
s/export HADOOP_PID_DIR=${HADOOP_PID_DIR}/export HADOOP_PID_DIR='"${HADOOP_PID_DIR//\//\\\/}"'/
'
sudo -u hadoop sed -i "${commands}" /data/conf/hadoop/hadoop-env.sh

sudo -u hadoop ln -snf /data/conf/hadoop /home/hadoop/hadoop-current/etc/hadoop

# install hbase

# setup environment
hadoop_path="/home/hadoop/hadoop-current/bin:/home/hadoop/hadoop-current/sbin"
sudo -u hadoop echo "export PATH=\"${hadoop_path}:${PATH}\"" >> /home/hadoop/.bash_profile
