#!/bin/bash
blobfuse /mnt/azure/data-provisioning --tmp-path=/mnt/azure/fusetmp/data-provisioning --config-file=/etc/fuse_connections/data_provisioning_fuse.cfg -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120 -o nonempty -o allow_other