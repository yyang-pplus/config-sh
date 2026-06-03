#!/bin/bash

set -euo pipefail

#
# This script installs required dependencies.
#

sudo apt update

sudo apt --yes install shunit2
