#!/bin/bash

set -e

if which anki &> /dev/null; then
    echo "Anki already installed."
    exit 0
fi

##
# @reference    Installing & Upgrading Anki on Linux
#               https://docs.ankiweb.net/platform/linux/installing.html
##
sudo apt --yes install libxcb-xinerama0 libxcb-cursor0 libnss3 zstd

temp_dir="/tmp/$(date +%s)"
mkdir $temp_dir

pushd $temp_dir

VERSION="24.11"
PACKAGE_NAME="anki-$VERSION-linux-qt6"
INSTALLER_URL="https://github.com/ankitects/anki/releases/download/$VERSION/$PACKAGE_NAME.tar.zst"

wget "$INSTALLER_URL"

tar xaf $PACKAGE_NAME.tar.zst
pushd $PACKAGE_NAME
sudo ./install.sh
popd
popd

rm -rf "$temp_dir"
