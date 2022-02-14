#!/bin/bash
if nvidia-smi > /dev/null; 
then     
    echo { \"status\": 1 }
else     
    echo { \"status\": 0 }
fi