#!/bin/bash
	
##############################
## Get Environment Variables #
##############################
source ./scrip-ninja-automation/products/docker_getenv.sh
source ./scrip-ninja-automation/products/read_config.sh

#####################
## Docker get login #
#####################
docker login --username=$DOCKER_HUB_LOGIN_USR --password=$DOCKER_HUB_LOGIN_PSW

###############################################
## Pushing the image to repository on Dockerhub #
###############################################
docker push $REGISTRY/$NAME:$VERSION || exit 1
set +x	