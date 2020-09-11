#!/bin/bash

source ~/.bash_util.sh

PROJECT_ROOT_DIR=$(pwd)
CPP_FILES_FILE=/tmp/cpp.cscope

# Use the first command argument if possible,
# Use current working directory otherwise
if [ $# -eq 1 ]; then
    if [ -d "$1" ]; then
        PROJECT_ROOT_DIR="$1"
    fi
fi

echo "Building cscope database for \""$PROJECT_ROOT_DIR"\"."

#Find all CPP files
QuietRun pushd /
find "$PROJECT_ROOT_DIR" -name '*.c' -or -name '*.h' -or -name '*.hpp' -or -name '*.cpp' -or -name '*.cc' > "$CPP_FILES_FILE"
QuietRun popd

#Build cscope database
#   reference: http://cscope.sourceforge.net/large_projects.html
QuietRun pushd "$PROJECT_ROOT_DIR"
cscope -b -q -i "$CPP_FILES_FILE"
QuietRun popd
