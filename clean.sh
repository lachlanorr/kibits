#!/bin/bash

# Delete any builds that have been made.
# This is the nuclear option, bootstrap.sh (or cmake manually) must be
# run after this.

KIBITS_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUILD_ROOT="$KIBITS_ROOT/build"

if [ -d "$BUILD_ROOT" ]
then
    echo Cleaning $BUILD_ROOT
    rm -rf $BUILD_ROOT
fi
