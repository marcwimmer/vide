#!/bin/bash
set -ex
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
rm -Rf /tmp/neovim || true
#brew install libtool automake cmake pkg-config gettext
git clone https://github.com/neovim/neovim /tmp/neovim
cd /tmp/neovim
git checkout -f $(cat $DIR/NEOVIMREVISION)
git clean -xdff
make -j4 CMAKE_BUILD_TYPE=Release
sudo make install
