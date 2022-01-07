#!/bin/bash
if [ -d "${1}" ] 
then
    echo "{ \"exists\": 1, \"name\": \""${1}"\" }"
else
    echo "{ \"exists\": 0, \"name\": \""${1}"\" }"
fi
