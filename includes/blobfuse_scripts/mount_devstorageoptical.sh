#!/bin/bash
blobfuse /mnt/azure/devstorageoptical --tmp-path=/mnt/azure/fusetmp/devstorageoptical --config-file=/etc/fuse_connections/devstorageoptical_fuse.cfg -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120 -o nonempty  -o allow_other