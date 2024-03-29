#!/bin/bash

source ~/.bash_util.sh

echo "Usage: $(basename $0) [<project_root_dir>]"

# Use the first command argument if possible, Use current working directory otherwise
PROJECT_ROOT_DIR=${1:-$(pwd)}

echo "Building ctags database for \""$PROJECT_ROOT_DIR"\"."

#Build ctags database
#   reference: https://www.topbug.net/blog/2012/03/17/generate-ctags-files-for-c-slash-c-plus-plus-source-files-and-all-of-their-included-header-files/
QuietRun pushd "$PROJECT_ROOT_DIR"
ctags -R --c++-kinds=+pl --fields=+iaS --extra=+q .
QuietRun popd
