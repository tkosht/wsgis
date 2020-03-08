#!/bin/sh

base_dir=../ds3.6

files_list="
Makefile
Dockerfile
docker-compose.yml
requirements.txt
bin/g.sh
.devcontainer
.env
"

for f in $files_list
do
    d=$(dirname $f)
    if [ "$d" != "." ]; then
        mkdir -p $d
    fi
    cp -pr $base_dir/$f ./$d
done

