#!/bin/bash
blobfuse /mnt/azure/cameraparams --tmp-path=/mnt/azure/cameraparams-fusetmp --config-file=/etc/fuse_connections/cameraparams_fuse.cfg -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120 -o nonempty  -o allow_other