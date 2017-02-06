
# if there is a source project that you are trying to build and it does not exist, it will attempt to be cloned. this variable is the base path to the repo where the projects live
export GIT_REMOTE_BASE=git@github.com:PLOS

# this is the path to the envoy project. you can set it here, or export it before this script exeutes
export ENVOY=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )/envoy

# default paths to directories in your dockerfiles directory
export PROJECTS=$DOCKERFILES/projects

export TESTS=$DOCKERFILES/tests

export CONFIGURATIONS=$DOCKERFILES/configurations

[[ -n $ENVOY ]] || {
  echo "Error: ENVOY environment variable not set.";
  echo "Please set set it to the path of the envoy scripts directory.";
  exit 5;

  # TODO: or git checkout envoy?
}

[[ -n $DOCKERFILES ]] || {
  echo "Error: DOCKERFILES environment variable not set.";
  exit 6;
}

# echo ENVOY: $ENVOY
# echo DOCKERFILES: $DOCKERFILES
# echo CONFIGURATIONS: $CONFIGURATIONS

source $ENVOY/build-helpers.sh
source $ENVOY/stack-helpers.sh