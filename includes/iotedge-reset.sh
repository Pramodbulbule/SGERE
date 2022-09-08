#!/bin/sh
docker container prune -f
docker image prune -a -f
systemctl stop aziot-edged
rm -r /var/lib/aziot/certd/*
rm -r /var/lib/aziot/edged/*
rm -r /var/lib/aziot/identityd/*
rm -r /var/lib/aziot/keyd/*
rm -r /var/lib/aziot/tpmd/*
rm -r /etc/iotedge/storage/*
systemctl start aziot-edged