#!/bin/bash
set -e
set -x

#silver surfer
apt-get install -y automake pkg-config liblzma-dev libpcre3-dev
git clone --depth 1 --branch master https://github.com/ggreer/the_silver_searcher /tmp/ag
cd /tmp/ag
./build.sh
make install
