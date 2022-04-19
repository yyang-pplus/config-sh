#!/bin/bash

set -e

echo "Initiating Bash history."

cat >> $HOME/.bash_history << EOF
$HOME/projects/script-sh/git/astyle_and_build.sh
$HOME/projects/script-sh/git/forward_and_checkout.sh master temp

git commit -a --amend --no-edit
git push origin HEAD:refs/for/master

gvim -S $HOME/tmp/session.vim
EOF
