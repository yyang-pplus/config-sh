#!/bin/bash

set -euo pipefail

sudo apt --yes install flatpak

flatpak install flathub --user -y net.lutris.Lutris
flatpak install flathub --user -y com.heroicgameslauncher.hgl
