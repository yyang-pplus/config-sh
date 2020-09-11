#!/bin/bash

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"

Install_Packages python3-pip python-is-python3

sudo pip3 install pipenv
sudo pip3 install black
sudo pip3 install pre-commit
