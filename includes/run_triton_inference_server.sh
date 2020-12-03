#!/bin/bash
docker run --name tis --gpus '"device=0,1,2"' --shm-size=1g --ulimit memlock=-1 --ulimit stack=67108864 --rm \
  -p8000:8000 -p8001:8001 -p8002:8002 \
  -v/mnt/azure/models:/models \
  nvcr.io/nvidia/tritonserver:20.09-py3 tritonserver \
  --model-repository=/models --model-control-mode=poll --repository-poll-secs 5