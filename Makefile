default: build

all: default stress

stress:
	sh bin/do_stress.sh

stats-log:
	@sh bin/log.sh

bash: up
	docker-compose exec app bash

up: _up ssh

ssh:
	docker-compose exec app sudo service ssh start

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

