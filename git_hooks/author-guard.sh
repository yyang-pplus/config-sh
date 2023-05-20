#!/bin/bash

set -e

EXPECTED_NAME=$(git config --global user.name)

if git remote -v | grep "yyang-pplus" > /dev/null; then
    EXPECTED_EMAIL_SUBSTR="pplus"
elif git remote -v | grep "yyang-even" > /dev/null; then
    EXPECTED_EMAIL_SUBSTR="even"
fi

if [[ "$GIT_AUTHOR_EMAIL" != *"$EXPECTED_EMAIL_SUBSTR@"* ]] || [[ -z "$GIT_AUTHOR_EMAIL" ]]; then
    echo "Unexpected user email. Expect: '$EXPECTED_EMAIL_SUBSTR'"
    echo "Use following command to fix it:"
    echo "    git config --local user.email 'yyang@example.com'"
    exit 1
fi

if [[ $EXPECTED_NAME != $GIT_AUTHOR_NAME ]]; then
    echo "Unexpected user name. Expect: '$EXPECTED_NAME'"
    exit 1
fi
