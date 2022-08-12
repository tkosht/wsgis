#!/bin/sh
d=$(cd $(dirname $0) && pwd)
cd $d/../

stressor(){
    service=$1
    protocol=$2
    n_reqs=4000
    n_maxconc=50
    n_threads=4
    docker compose exec stressor \
        h2load -p $protocol \
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
uvicorn.fastapi
gunicorn.fastapi
daphne.fastapi
"

service_list2="
hypercorn.fastapi
"

rm -rf log
mkdir -p log/stats
mkdir -p log/wsgi
docker compose up -d stressor

# HTTP/1.1
protocol=http/1.1
for service in $service_list
do
    echo "Processing ... $service"
    docker compose up -d $service
    sleep 3
    stressor $service $protocol > log/stats/stats.$service.log
    docker compose stop $service
    docker compose rm -f $service
    # break       # for debugging
done


# HTTP/2
protocol=h2c    # without SSL/TLS
for service in $service_list2
do
    echo "Processing ... $service"
    docker compose up -d $service
    sleep 3
    stressor $service $protocol > log/stats/stats.$service.log
    docker compose stop $service
    docker compose rm -f $service
    # break       # for debugging
done

docker compose stop stressor
docker compose rm -f stressor
