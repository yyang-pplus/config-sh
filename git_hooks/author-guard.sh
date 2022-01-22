#!/bin/bash

set -e

EXPECTED_EMAIL=$(git config --global user.email)
EXPECTED_NAME=$(git config --global user.name)

if [[ $EXPECTED_EMAIL != $GIT_AUTHOR_EMAIL ]]; then
    echo "Unexpected email. Expect: '$EXPECTED_EMAIL'"
    exit 1
fi

if [[ $EXPECTED_NAME != $GIT_AUTHOR_NAME ]]; then
    echo "Unexpected name. Expect: '$EXPECTED_NAME'"
    exit 1
fi
