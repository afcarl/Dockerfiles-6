#!/bin/bash

source /shared/compile-helpers.sh

java_compile_prepare

./ned.sh install
cp target/*.?ar $BUILDDIR
cp src/main/resources/ned-*.mysql.sql $BUILDDIR

java_compile_finish "target/classes/version.properties"
