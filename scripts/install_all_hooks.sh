#!/bin/bash

set -e

echo "Usage: $(basename $0) [<projects_dir>]"

PROJECTS_DIR=$(readlink --canonicalize "${1:-$HOME/projects}")

pushd $PROJECTS_DIR
ALL_PROJECTS=($(ls))

for one_project in "${ALL_PROJECTS[@]}"; do
    if [ -d "$one_project/.git" ]; then

        pushd "$one_project"

        if [ ! -f ".git/hooks/pre-commit" ]; then
            cp "$PROJECTS_DIR/config-sh/git_hooks/author-guard.sh" ".git/hooks/pre-commit"

            if git remote -v | grep -q 'yyang-even'; then
                sed -i -E s/^\(EXPECTED_EMAIL=\).+/\\1\"yyang.even@gmail.com\"/ ".git/hooks/pre-commit"

                git config --local user.email "yyang.even@gmail.com"
            fi
        fi

        ln --symbolic --force --no-target-directory "$PROJECTS_DIR/config-sh/git_hooks/push-guard.sh" ".git/hooks/pre-push"

        # Keep pre-commit last
        pre-commit install
        popd
    fi
done
popd
