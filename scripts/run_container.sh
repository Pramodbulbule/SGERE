#!/bin/bash

base="$(cd "$(dirname "$0")"; pwd)"

docker run --rm -it --net=host \
  --env ANSIBLE_REMOTE_USER=$(cat $base/../includes/user_config/ssh/username) \
  -v "$base/../":/mnt/em-provisioning \
  -v "$base/../includes/user_config/ssh":/mnt/ssh \
  -v "$base/../includes/user_config/home/.bashrc":/root/.bashrc \
  -v "$base/../hosts":/etc/ansible/hosts \
  -v ~/.ssh/id_rsa:/root/.ssh/id_rsa:ro \
  -v ~/.ssh/id_rsa.pub:/root/.ssh/id_rsa.pub:ro \
  em-provisioning /bin/bash
