#!/bin/bash
set -e
set -x

TMP=/tmp/ag

#silver surfer
apt-get install -y automake pkg-config liblzma-dev libpcre3-dev
if [[ "$(find $TMP -type f|wc -l)" == "0" ]]; then
    git clone --depth 1 --branch master https://github.com/ggreer/the_silver_searcher $TMP 
fi
cd $TMP
./build.sh
make install
