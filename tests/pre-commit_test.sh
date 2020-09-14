#!/bin/bash

# set -ex

pre-commit install

pre-commit autoupdate

pre-commit run --all-files

# This test is disabled because of the following pip error on Travis:
#   ERROR: pre-commit 2.7.1 has requirement virtualenv>=20.0.8, but you'll have virtualenv 15.1.0 which is incompatible.
exit 0
