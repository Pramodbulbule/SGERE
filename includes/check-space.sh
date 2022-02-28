#!/bin/bash
USAGE=$(df --output=pcent ${1} | sed 1d | tr -d "%"  | xargs)
echo { \"usage\": $USAGE, \"mount\": \"${1}\" }
