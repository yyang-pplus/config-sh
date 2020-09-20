#!/bin/bash

set -e

echo "Usage: $(basename $0) [<projects_dir>]"

PROJECTS_DIR=${1:-$(pwd)}

pushd $PROJECTS_DIR
ALL_PROJECTS=($(ls))

for one_project in "${ALL_PROJECTS[@]}"; do
    if [ -d "$one_project/.git" ]; then

        pushd "$one_project"
        pre-commit install
        popd
    fi
done
popd
