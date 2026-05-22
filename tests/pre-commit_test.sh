#!/bin/bash

set -exuo pipefail

pre-commit install

pre-commit run --all-files
