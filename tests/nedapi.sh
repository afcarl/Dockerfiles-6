#!/bin/bash

# set -x

SCRIPTDIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
COMPOSE_FILE=nedapi.yml

source $SCRIPTDIR/test-helpers.sh

start_stack

SVC_URL=$(get_docker_host):8081/v1
SVC_NAME="NED"

wait_for_web_service $SVC_URL $SVC_NAME

# begin tests

curl_test_ok $SVC_URL/service/config $SVC_NAME

curl_test_ok $SVC_URL/typeclasses "Authenticated request" "-u dev:dev"

# end tests

tests_passed

stop_stack
