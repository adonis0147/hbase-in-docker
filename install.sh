#!/bin/bash

HOME="$(dirname "${BASH_SOURCE[0]}")"
INSTALL_PATH="${HOME}/install"
ARCHIVES_PATH="${INSTALL_PATH}/archives"
SSHKEY_PATH="${INSTALL_PATH}/ssh"

hadoop_package='hadoop-2.10.0.tar.gz'
hadoop_package_url='http://mirrors.aliyun.com/apache/hadoop/common/hadoop-2.10.0/hadoop-2.10.0.tar.gz'

zookeeper_package='apache-zookeeper-3.5.6-bin.tar.gz'
zookeeper_package_url='https://mirrors.aliyun.com/apache/zookeeper/stable/apache-zookeeper-3.5.6-bin.tar.gz'

hbase_package='hbase-1.4.12-bin.tar.gz'
hbase_package_url='https://mirrors.aliyun.com/apache/hbase/hbase-1.4.12/hbase-1.4.12-bin.tar.gz'

if [[ ! -f "${ARCHIVES_PATH}/${hadoop_package}" ]]; then
  echo 'download hadoop'
  curl -fLo "${ARCHIVES_PATH}/${hadoop_package}" --create-dirs "${hadoop_package_url}"
fi

if [[ ! -f "${ARCHIVES_PATH}/${zookeeper_package}" ]]; then
  echo 'download zookeeper'
  curl -fLo "${ARCHIVES_PATH}/${zookeeper_package}" --create-dirs "${zookeeper_package_url}"
fi

if [[ ! -f "${ARCHIVES_PATH}/${hbase_package}" ]]; then
  echo 'download hbase'
  curl -fLo "${ARCHIVES_PATH}/${hbase_package}" --create-dirs "${hbase_package_url}"
fi

mkdir -p "${SSHKEY_PATH}"
yes | ssh-keygen -t rsa -N '' -f "${SSHKEY_PATH}/id_rsa"

docker build -t hbase-in-docker .
