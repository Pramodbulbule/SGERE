#!/bin/bash
blobfuse /mnt/azure/models --tmp-path=/mnt/azure/models-fusetmp --config-file=/etc/fuse_connections/mlmodels_fuse.cfg -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120 -o nonempty -o allow_other