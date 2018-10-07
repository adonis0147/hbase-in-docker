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
  --network hadoop \
  --hostname hbase-cluster-n1.com \
  --name hbase-cluster-n1.com \
  --mount source=home1,target=/home/hadoop \
  --mount source=disk1,target=/data \
  hbase-in-docker

docker run -itd \
  --network hadoop \
  --hostname hbase-cluster-n2.com \
  --name hbase-cluster-n2.com \
  --mount source=home2,target=/home/hadoop \
  --mount source=disk2,target=/data \
  hbase-in-docker

docker run -itd \
  --network hadoop \
  --hostname hbase-cluster-n3.com \
  --name hbase-cluster-n3.com \
  --mount source=home3,target=/home/hadoop \
  --mount source=disk3,target=/data \
  hbase-in-docker

