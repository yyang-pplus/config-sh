#!/bin/bash

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"


REDHAT_PACKAGES_LIST="vim-X11 ctags"
DEBIAN_PACKAGES_LIST="vim-gnome exuberant-ctags"
COMMON_PACKAGES_LIST="cscope"

redhat_packages_list=$REDHAT_PACKAGES_LIST debian_packages_list=$DEBIAN_PACKAGES_LIST Install_Packages $COMMON_PACKAGES_LIST
