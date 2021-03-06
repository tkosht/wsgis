#!/bin/sh
d=$(cd $(dirname $0) && pwd)
cd $d/../

stressor(){
    service=$1
    n_reqs=2000
    n_maxconc=50
    n_threads=4
    docker-compose exec stressor \
        h2load -p http/1.1 \
            -n $n_reqs -c $n_reqs \
            -m $n_maxconc -t $n_threads \
            http://$service:8000/hello
}

service_list="
gunicorn.falcon
gunicorn.flask
gunicorn.responder
uwsgi.falcon
uwsgi.flask
"

rm -rf log
mkdir -p log/stats
mkdir -p log/wsgi
docker-compose up -d stressor

for service in $service_list
do
    docker-compose up -d $service
    stressor $service | tee log/stats/stats.$service.log
    docker-compose stop $service
    # break       # for debugging
done

docker-compose stop stressor
