#!/bin/sh
jq -R -r '. as $line | try (fromjson |  [.asctime, .levelname, .filename, .lineno, .threadName, .message] | .[0] + " " +.[1] + " [" + .[2] + ":" + (.[3] | tostring) + "] " + .[4] + ": " +.[5]) catch $line'
