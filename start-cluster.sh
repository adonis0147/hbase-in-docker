#!/bin/bash

if ! docker network ls | grep hadoop > /dev/null; then
  echo "create network hadoop"
  docker network create \
    --driver=bridge \
    --subnet=172.18.0.0/16 \
    --opt com.docker.network.bridge.name=br-hadoop \
    hadoop
fi

docker run -itd \
  --network=hadoop \
  --hostname=hbase-cluster-n1.com \
  --name=hbase-cluster-n1 \
  --mount=source=home1,target=/home/hadoop \
  --mount=source=disk1,target=/data \
  --ip=172.18.0.2 \
  --add-host=hbase-cluster-n1.com:172.18.0.2 \
  --add-host=hbase-cluster-n2.com:172.18.0.3 \
  --add-host=hbase-cluster-n3.com:172.18.0.4 \
  hbase-in-docker

docker run -itd \
  --network=hadoop \
  --hostname=hbase-cluster-n2.com \
  --name=hbase-cluster-n2 \
  --mount=source=home2,target=/home/hadoop \
  --mount=source=disk2,target=/data \
  --ip=172.18.0.3 \
  --add-host=hbase-cluster-n1.com:172.18.0.2 \
  --add-host=hbase-cluster-n2.com:172.18.0.3 \
  --add-host=hbase-cluster-n3.com:172.18.0.4 \
  hbase-in-docker

docker run -itd \
  --network=hadoop \
  --hostname=hbase-cluster-n3.com \
  --name=hbase-cluster-n3 \
  --mount=source=home3,target=/home/hadoop \
  --mount=source=disk3,target=/data \
  --ip=172.18.0.4 \
  --add-host=hbase-cluster-n1.com:172.18.0.2 \
  --add-host=hbase-cluster-n2.com:172.18.0.3 \
  --add-host=hbase-cluster-n3.com:172.18.0.4 \
  hbase-in-docker
