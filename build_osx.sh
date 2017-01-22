#!/bin/bash
set -ex
rm -Rf /tmp/neovim || true
#brew install libtool automake cmake pkg-config gettext
git clone https://github.com/neovim/neovim /tmp/neovim
cd /tmp/neovim
make -j4 CMAKE_BUILD_TYPE=Release
sudo make install
