#!/bin/bash

set -ex

pre-commit install

pre-commit autoupdate

# This test is disabled because of the following error on Travis:
#   An unexpected error has occurred: AssertionError: BUG: expected environment for python
#   to be healthy() immediately after install, please open an issue describing your environment
# pre-commit run --all-files
