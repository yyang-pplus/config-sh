#!/bin/bash

set -e

THIS_DIR=$(dirname "$0")
PROJECTS_DIR=$(readlink --canonicalize "$THIS_DIR/../..")

echo "Initiating Bash history."
cat >> $HOME/.bash_history << EOF
$PROJECTS_DIR/script-sh/git/build.sh
$PROJECTS_DIR/script-sh/git/forward_and_checkout.sh master temp

git commit -a --amend --no-edit
git push origin HEAD:refs/for/master

gvim -S $HOME/tmp/session.vim
EOF
