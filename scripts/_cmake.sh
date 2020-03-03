#!/bin/bash

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"


debian_packages_list="cmake-curses-gui" Install_Packages cmake cmake-gui
