#!/bin/bash

set -e

THIS_DIR=$(dirname "$0")
source "$THIS_DIR/util.sh"

if which anki &> /dev/null; then
    echo "Anki already installed."
    # exit 0
fi

##
# @reference    Installing & Upgrading Anki on Linux
#               https://docs.ankiweb.net/platform/linux/installing.html
##
$SUDO_CMD apt --yes install libxcb-xinerama0 libxcb-cursor0 libnss3 zstd mpv

temp_dir="/tmp/$(date +%s)"
mkdir $temp_dir

pushd $temp_dir

VERSION="25.09"
PACKAGE_NAME="anki-launcher-$VERSION-linux"
INSTALLER_URL="https://github.com/ankitects/anki/releases/download/$VERSION/$PACKAGE_NAME.tar.zst"

wget "$INSTALLER_URL"

tar xaf $PACKAGE_NAME.tar.zst
pushd $PACKAGE_NAME
$SUDO_CMD ./install.sh
popd
popd

rm -rf "$temp_dir"
