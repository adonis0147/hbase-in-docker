#!/bin/bash

HOME="$(dirname ${BASH_SOURCE[0]})"
INSTALL_PATH="${HOME}/install"
ARCHIVES_PATH="${INSTALL_PATH}/archives"
SSHKEY_PATH="${INSTALL_PATH}/ssh"

if [[ ! -f "${ARCHIVES_PATH}/hadoop-2.9.1.tar.gz" ]]; then
  echo 'download hadoop'
  curl -fLo "${ARCHIVES_PATH}/hadoop-2.9.1.tar.gz" --create-dirs \
    https://mirrors.aliyun.com/apache/hadoop/common/hadoop-2.9.1/hadoop-2.9.1.tar.gz
fi

if [[ ! -f "${ARCHIVES_PATH}/hbase-1.4.7-bin.tar.gz" ]]; then
  echo 'download hbase'
  curl -fLo "${ARCHIVES_PATH}/hbase-1.4.7-bin.tar.gz" --create-dirs \
    https://mirrors.aliyun.com/apache/hbase/1.4.7/hbase-1.4.7-bin.tar.gz
fi

mkdir -p "${SSHKEY_PATH}"
yes | ssh-keygen -t rsa -N '' -f "${SSHKEY_PATH}/id_rsa"

docker build -t hbase-in-docker .
