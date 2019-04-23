IMAGE_NAME?=bipole3/kdt
IMAGE_TAG?=1.0.0-alpine
FOLDER?=

ENV_ARGS := --rm --name "kdt-$$(date +'%Y%m%d-%H%M%S')" -v kube:/home/devops/.kube -p 8080:8080
ifneq ($(FOLDER),)
  ENV_ARGS := ${ENV_ARGS} -v ${FOLDER}:/home/devops/mounted -w /home/devops/mounted
endif

image-generate:
	docker build -t "${IMAGE_NAME}:${IMAGE_TAG}" .

image-remove:
	docker rmi -f "${IMAGE_NAME}:${IMAGE_TAG}"

env-build:
	docker-compose up -d

env-attach: env-build
	docker-compose run ${ENV_ARGS} kdt-machine

env-remove:
	docker-compose down -v --rmi all

