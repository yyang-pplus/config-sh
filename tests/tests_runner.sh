#!/bin/bash

set -exuo pipefail

THIS_DIR=$(dirname "$0")

pushd $THIS_DIR
SELECTED_TESTS=($(ls *_test.sh))

for test_script in "${SELECTED_TESTS[@]}"; do
    ./$test_script
done
popd
