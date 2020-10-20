#!/bin/bash

base="$(cd "$(dirname "$0")"; pwd)"

docker run --rm -it --net=host \
  --env ANSIBLE_REMOTE_USER=$(cat $base/../includes/user_config/ssh/username) \
  -v "$base/../":/mnt/em-provisioning \
  -v "$base/../includes/user_config/ssh":/mnt/ssh \
  -v "$base/../includes/user_config/home/.bashrc":/root/.bashrc \
  -v "$base/../hosts":/etc/ansible/hosts \
  em-provisioning /bin/bash
