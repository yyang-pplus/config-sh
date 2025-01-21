#!/bin/bash

set -e

THIS_DIR=$(dirname "$0")
CONFIG_SH_DIR=$(readlink --canonicalize "$THIS_DIR/../..")
PROJECT_ROOT_DIR=$(git rev-parse --show-toplevel)

pushd "$PROJECT_ROOT_DIR"

ln --symbolic --force --no-target-directory "$CONFIG_SH_DIR/git_hooks/author-guard.sh" ".git/hooks/pre-commit"
ln --symbolic --force --no-target-directory "$CONFIG_SH_DIR/git_hooks/push-guard.sh" ".git/hooks/pre-push"

# Keep pre-commit last
if [ -f ".pre-commit-config.yaml" ]; then
    pre-commit install
fi
popd
