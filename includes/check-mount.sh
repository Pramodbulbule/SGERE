#!/bin/bash
if grep -qs ${2} /proc/mounts;
then
    echo "{ \"exists\": 1, \"name\": \""${1}"\", \"path\": \""${2}"\" }"
else
    echo "{ \"exists\": 0, \"name\": \""${1}"\", \"path\": \""${2}"\" }"
fi
