### repo variables
PROJECT_USER=kaybenleroll
PROJECT_TAG=latest

PROJECT_NAME=nlp-stanza

PYTHON_IMAGE_TAG=${PROJECT_USER}/${PROJECT_NAME}-python:${PROJECT_TAG}

PYTHON_CONTAINER_NAME=nlp-workspace


DOCKER_USER=jupyter
DOCKER_PASS=CHANGEME
DOCKER_UID=$(shell id -u)
DOCKER_GID=$(shell id -g)
DOCKER_BUILD_ARGS=

RSTUDIO_PORT=8787
SHINY_PORT=5113

PROJECT_FOLDER=graphdb_create

LIB_DIR=${PWD}/../libs
AISDB_FILEDIR=${HOME}/aisdb_files


### Set GITHUB_USER with 'gh config set gh_user <<user>>'
GITHUB_USER=$(shell gh config get gh_user)

PROJECT_BASEFOLDER=/home/${DOCKER_USER}/${PROJECT_FOLDER}


### Docker targets
docker-build-anaconda-image: Dockerfile.anaconda
	docker build -t ${PYTHON_IMAGE_TAG} \
	  ${DOCKER_BUILD_ARGS} \
	  --build-arg BUILD_DATE=$(shell date -u +'%Y-%m-%dT%H:%M:%SZ') \
	  -f Dockerfile.anaconda . 2>&1 | tee -a docker_build_anaconda.log


docker-run-python:
	docker run --rm -i -t \
	  -v "${PWD}":"/opt/notebooks":rw \
	  -p 8888:8888 \
	  --name ${PYTHON_CONTAINER_NAME} \
	  ${PYTHON_IMAGE_TAG} \
	  /bin/bash -c "\
	    jupyter notebook \
	    --notebook-dir=/opt/notebooks --ip='*' --port=8888 \
	    --no-browser --allow-root"

docker-bash:
	docker exec -it -u ${DOCKER_USER} ${PYTHON_CONTAINER_NAME} bash


