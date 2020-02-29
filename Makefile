default: build

all: default stress

stress:
	sh bin/do_stress.sh

up:
	docker-compose up -d app

ps images down:
	docker-compose $@

im:images

build:
	docker-compose build --no-cache

reup: down up

clean:
	docker-compose down --rmi all
	sudo rm -rf app/__pycache__
