#!/bin/bash

set -e

echo "Usage: $(basename $0) [<projects_dir>]"

PROJECTS_DIR=$(readlink --canonicalize "${1:-$HOME/projects}")

pushd $PROJECTS_DIR
ALL_PROJECTS=($(ls))

for one_project in "${ALL_PROJECTS[@]}"; do
    if [ -d "$one_project/.git" ]; then

        pushd "$one_project"
        pre-commit install

        ln --symbolic --force --no-target-directory "$PROJECTS_DIR/yyLinuxConfig/git_hooks/push-guard.sh" ".git/hooks/pre-push"
        popd
    fi
done
popd
