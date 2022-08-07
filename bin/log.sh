#!/usr/bin/sh
d=$(cd $(dirname $0) && pwd)
cd $d/../

cd log/stats/
egrep '^finished' stats.*.log
