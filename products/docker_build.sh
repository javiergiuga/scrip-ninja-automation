#!/bin/bash
# get variables form gitlab-ci or locals
source ./scrip-ninja-automation/products/read_config.sh
source ./scrip-ninja-automation/products/docker_getenv.sh

docker build $1 $2 \
        --build-arg VCS_REF=`git rev-parse --short HEAD` \
        --build-arg BUILD_DATE=`date -u +"%Y-%m-%dT%H:%M:%SZ"` \
        --build-arg GIT_USER="$GIT_USER" \
        --build-arg GIT_USER_EMAIL="$GIT_USER_EMAIL"  \
        -t $REGISTRY/$NAMEP:$VERSION products/. || exit 1

# docker build $1 $2 -t $REGISTRY/$REPOSITORY:$VERSION . || exit 1        