#!/bin/bash

set -ex

pre-commit install

pre-commit run --all-files
