#!/bin/bash

set -e

echo "Usage: $(basename $0) [<projects_dir>]"

PROJECTS_DIR=$(readlink --canonicalize "${1:-$HOME/projects}")

pushd $PROJECTS_DIR
ALL_PROJECTS=($(ls))

for one_project in "${ALL_PROJECTS[@]}"; do
    if [ -d "$one_project/.git" ]; then

        pushd "$one_project"
        ln --symbolic --force --no-target-directory "$PROJECTS_DIR/config-sh/git_hooks/push-guard.sh" ".git/hooks/pre-push"

        # Keep pre-commit last
        pre-commit install
        popd
    fi
done
popd
