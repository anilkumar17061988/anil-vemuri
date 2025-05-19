all: clean start-minikube docker-env build deploy

clean:
	@echo "Cleaning previous Docker and Kubernetes setup..."
	-docker stop jenkins-server
	-docker rm jenkins-server
	-docker volume rm jenkins_home
	kubectl delete deployment my-app-deployment --namespace=default --ignore-not-found
	kubectl delete service my-app-deployment --namespace=default --ignore-not-found
	@echo "Cleanup complete."

start-minikube:
	@echo "Starting Minikube..."
	minikube start --driver=docker

docker-env:
	@echo "Run this command in PowerShell to configure Docker:"
	@echo "minikube docker-env --shell powershell | Invoke-Expression"

build:
	@echo "Building Docker image..."
	docker build -t rjshsynectiks/node-js-sample:latest ./app

deploy:
	@echo "Applying Kubernetes manifests..."
	kubectl apply -f k8s/deployment.yaml
	kubectl apply -f k8s/service.yaml
