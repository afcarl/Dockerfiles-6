#!/usr/bin/env bash

# TODO: move this into build-helpers.sh for reuse (build_java_executable)

SRC=../../../mediaTracker/

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR
SRC=$DIR/$SRC

BASEIMAGE=maven:3.3-jdk-8
MAVEN_CACHE=maven_cache
BUILD_CACHE=mediatrackerbuild
# HOST_CACHE=$DIR/build_cache
TMP_BUILD_CONTAINER=mediatracker_temp_container
OUTPUTIMAGE=mediatracker
BASE_TAG=current

if [ "$1" == "clean" ]; then
   echo Removing cache
   docker rm $MAVEN_CACHE
   exit 0
fi

# TODO: run tests in build

BASE_TAG=$(git --git-dir=$SRC/.git rev-parse --abbrev-ref HEAD|sed -e 's/[^a-zA-Z0-9_.]/_/g')

# create the cache for mavan
docker create -v /build --name $BUILD_CACHE $BASEIMAGE /bin/true

# create the volume for sharing compiled java assets
docker create -v /root/.m2 --name $MAVEN_CACHE $BASEIMAGE /bin/true

# build jar
docker run --rm \
   --volumes-from $MAVEN_CACHE \
   --volumes-from $BUILD_CACHE \
   --volume $SRC:/src \
   --volume $DIR:/scripts \
   --volume $DIR/..:/shared \
   $BASEIMAGE bash /scripts/compile.sh

docker build -t $OUTPUTIMAGE:$BASE_TAG .


echo Copying java assets into image

VERSION=$(docker run --volumes-from $BUILD_CACHE --name $TMP_BUILD_CONTAINER $OUTPUTIMAGE:$BASE_TAG sh -c 'cp /build/* /root; cat /root/version.txt')

docker commit $TMP_BUILD_CONTAINER $OUTPUTIMAGE:$BASE_TAG

# build docker images and tag them

echo tagging container with version : $VERSION

docker tag $OUTPUTIMAGE:$BASE_TAG $OUTPUTIMAGE:$VERSION

docker rm $TMP_BUILD_CONTAINER
