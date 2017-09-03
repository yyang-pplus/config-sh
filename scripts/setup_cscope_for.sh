#!/bin/bash

WORKING_DIR=$(pwd)
PROJECT_ROOT_DIR=$WORKING_DIR
CPP_FILES_FILE=/tmp/cpp.cscope


if [ $# -eq 1 ]; then
    if [ -d "$1" ]; then
        PROJECT_ROOT_DIR="$1"
    fi
fi

echo "Building cscope database for \""$PROJECT_ROOT_DIR"\"."

#Find all CPP files
pushd /
find "$PROJECT_ROOT_DIR" -name '*.c' -or -name '*.h' -or -name '*.hpp' -or -name '*.cpp' -or -name '*.cc' > "$CPP_FILES_FILE"
popd

#Build cscope database
#   reference: http://cscope.sourceforge.net/large_projects.html
pushd "$PROJECT_ROOT_DIR"
cscope -b -q -i "$CPP_FILES_FILE"
popd
