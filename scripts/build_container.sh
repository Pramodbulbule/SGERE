#!/bin/bash

base="$(cd "$(dirname "$0")"; pwd)";
ls $base/../Dockerfile.amd64
docker build \
  -t em-provisioning \
  -f $base/../Dockerfile.amd64 \
  .
