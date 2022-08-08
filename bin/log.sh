#!/usr/bin/sh
d=$(cd $(dirname $0) && pwd)
cd $d/../

if [ "$1" = "--requests" ]; then
    egrep --color=auto '(^requests|[0-9]{1,} succeeded)' log/stats/stats.*.log
elif [ "$1" = "--tat" ]; then
    egrep --color=auto '(mean|^time for request)' log/stats/stats.*.log
elif [ "$1" = "--throughput" ]; then
    egrep --color=auto '(mean|^req/s)' log/stats/stats.*.log
else
    egrep --color=auto '(^finished)' log/stats/stats.*.log
fi
