#!/bin/bash

set -ex

pre-commit install

pre-commit autoupdate

pre-commit run --all-files
