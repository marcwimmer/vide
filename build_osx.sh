#!/bin/bash
set -ex
rm -Rf /tmp/vim || true
git clone https://github.com/vim/vim /tmp/vim
cd /tmp/vim
./configure --with-features=huge --enable-pythoninterp
make -j4
sudo make install
