#!/bin/bash

source ~/.bash_util.sh

echo "Usage: $(basename $0) [<project_root_dir>]"

# Use the first command argument if possible, Use current working directory otherwise
PROJECT_ROOT_DIR=${1:-$(pwd)}
CPP_FILES_FILE=/tmp/cpp.cscope

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
