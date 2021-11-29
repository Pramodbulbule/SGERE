#!/bin/bash
blobfuse /mnt/azure/calibration --tmp-path=/mnt/azure/fusetmp/calibration --config-file=/etc/fuse_connections/calibration_fuse.cfg -o attr_timeout=240 -o entry_timeout=240 -o negative_timeout=120 -o nonempty -o allow_other