#!/bin/bash

set -e

USERNAME=$(git log --reverse -1 --format="%an")
EMAIL=$(git log --reverse -1 --format="%ae")

set -x

git config --local user.name "$USERNAME"
git config --local user.email "$EMAIL"
