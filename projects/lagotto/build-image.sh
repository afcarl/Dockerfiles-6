#!/usr/bin/env bash

source $FLATRACK/build-helpers.sh || source "$( dirname "${BASH_SOURCE[0]}" )"/../../flatrack/build-helpers.sh
  build_rails_passenger_image lagotto lagotto
