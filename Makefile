
include .env

.PYONY: build push env

env:
	[ -e .env ] && cat .env | grep -P -o "^.+=" > env.template

build:  
	docker build . -t $(DOCKERHUB_USER)/reportserver:3.2

push:
	docker push $(DOCKERHUB_USER)/reportserver:3.2