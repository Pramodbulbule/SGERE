#!/bin/bash
blobfuse /mnt/azure/ground/data --tmp-path=/mnt/azure/ground/data-fusetmp --config-file=/etc/fuse_connections/ground_truth_fuse.cfg -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120 -o nonempty  -o allow_other