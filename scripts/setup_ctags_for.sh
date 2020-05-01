#!/bin/bash

source ~/.bash_util.sh


PROJECT_ROOT_DIR=$(pwd)

# Use the first command argument if possible,
# Use current working directory otherwise
if [ $# -eq 1 ]; then
    if [ -d "$1" ]; then
        PROJECT_ROOT_DIR="$1"
    fi
fi

echo "Building ctags database for \""$PROJECT_ROOT_DIR"\"."

#Build ctags database
#   reference: https://www.topbug.net/blog/2012/03/17/generate-ctags-files-for-c-slash-c-plus-plus-source-files-and-all-of-their-included-header-files/
QuietRun pushd "$PROJECT_ROOT_DIR"
    ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .
QuietRun popd
