#!/bin/bash

base="$(cd "$(dirname "$0")"; pwd)";
ls $base/../Dockerfile.amd64
docker build \
  --build-arg ssh_prv_key="$(cat ~/.ssh/id_rsa)" \
  --build-arg ssh_pub_key="$(cat ~/.ssh/id_rsa.pub)" \
  -t em-provisioning \
  -f $base/../Dockerfile.amd64 \
  .
