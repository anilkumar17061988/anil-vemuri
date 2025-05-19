build:
	docker build -t anilkumar1988/node-js-sample:latest ./app

push:
	docker push anilkumar1988/node-js-sample:latest

deploy:
	kubectl apply -f k8s/deployment.yaml
	kubectl apply -f k8s/service.yaml

all: build push deploy
