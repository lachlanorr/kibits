#!/bin/bash

# Run this first on a clean system to prepare kibits build.
KIBITS_ROOT="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
BUILD_ROOT=$KIBITS_ROOT/build

cd $KIBITS_ROOT

git submodule init
git submodule update --init --recursive

if [ -z "$1" ]
    then
        BUILD_TYPE=Debug
    else
        BUILD_TYPE=$1
fi

BUILD_DIR=$BUILD_ROOT/$BUILD_TYPE

if [ ! -d "$BUILD_DIR" ]
then
    mkdir -p $BUILD_DIR
fi

cd $BUILD_DIR
pwd

# Run cmake
cmake -DCMAKE_BUILD_TYPE=${BUILD_TYPE} ${KIBITS_ROOT}

echo
echo To build, run make within $BUILD_DIR
