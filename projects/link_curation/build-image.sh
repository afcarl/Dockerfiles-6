#!/usr/bin/env bash

# set -x

IMAGE_NAME=linkcuration
PROJECT_NAME=linkcuration
PROJECT_DIR=link_curation

TMP_BUILD_CONTAINER=${IMAGE_NAME}_temp_container

BASE_TAG=current

DOCKER_SETUP_DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

# perhaps they supplied an absolute path to an existing project directory
if [ -d "$1" ]; then
	PROJECT_LOCAL_REPO=$1/
else
	PROJECT_LOCAL_REPO=$DOCKER_SETUP_DIR/../../../${PROJECT_DIR}/
fi

# TODO: git clone repo if it does not exist

cd $DOCKER_SETUP_DIR

cp Dockerfile $PROJECT_LOCAL_REPO      # this is a hack to allow the Dockerfile to exist in this subfolder
cp linkcuration.dockerignore $PROJECT_LOCAL_REPO/.dockerignore

cp *.yml $PROJECT_LOCAL_REPO/config

cat $PROJECT_LOCAL_REPO/.dockerignore

cd $PROJECT_LOCAL_REPO

BASE_TAG=$(git rev-parse --abbrev-ref HEAD|sed -e 's/[^a-zA-Z0-9_.]/_/g')

time docker build -t $IMAGE_NAME:$BASE_TAG .
# cd $DOCKER_SETUP_DIR
rm $PROJECT_LOCAL_REPO/Dockerfile
rm $PROJECT_LOCAL_REPO/.dockerignore

VERSION=$(docker run --volume $DOCKER_SETUP_DIR:/scripts \
						--volume $DOCKER_SETUP_DIR/..:/shared \
						--name $TMP_BUILD_CONTAINER $IMAGE_NAME:$BASE_TAG sh -c \
							'cp /shared/run-helpers.sh /scripts/* /root/;
					     cat /root/version.txt')

docker commit --change "CMD bash /root/run.sh" $TMP_BUILD_CONTAINER $IMAGE_NAME:$BASE_TAG

# tag docker image with asset version number

echo tagging container with version : $VERSION

docker tag $IMAGE_NAME:$BASE_TAG $IMAGE_NAME:$VERSION

docker rm $TMP_BUILD_CONTAINER