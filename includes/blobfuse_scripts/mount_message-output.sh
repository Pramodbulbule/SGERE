#!/bin/bash
blobfuse /mnt/azure/message-output --tmp-path=/mnt/azure/fusetmp/message-output --config-file=/etc/fuse_connections/message_output_fuse.cfg -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120 -o nonempty -o allow_other