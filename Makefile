default: build

all: default stress

stress:
	sh bin/do_stress.sh

log-stats-summary:
	@sh bin/log.sh

log-stats-requests:
	@sh bin/log.sh --requests

log-stats-tat:
	@sh bin/log.sh --tat

log-stats-throughput:
	@sh bin/log.sh --throughput


bash: up
	docker compose exec app bash

up: _up ssh

ssh:
	docker compose exec app sudo service ssh start

_up:
	docker compose up -d app

ps images down:
	docker compose $@

im:images

build:
	docker compose build --no-cache

reup: down up

clean:
	docker compose down --rmi all
	sudo rm -rf app/__pycache__

