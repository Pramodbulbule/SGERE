#!/bin/bash
result=$( docker ps -q -f name=${1} )
if [[ -n "$result" ]];
then
    echo "{ \"running\": 1, \"container_name\": \""${1}"\" }"
else
    echo "{ \"running\": 0, \"container_name\": \""${1}"\" }"
fi
