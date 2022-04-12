#!/bin/sh
docker container prune -f
docker image prune -a -f
systemctl stop iotedge
rm -r /var/lib/iotedge/hsm/*
rm -r /var/lib/iotedge/mnt/*
rm -r /var/lib/iotedge/cache/*
rm -r /etc/iotedge/storage/*
systemctl start iotedge