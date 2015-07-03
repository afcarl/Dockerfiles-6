#!/bin/bash

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR

FILES=`ls *.sh | grep -Ev "test-|JSON"`
for FILE in $FILES
do
  echo RUNNING TEST $FILE
  bash $FILE
done;
