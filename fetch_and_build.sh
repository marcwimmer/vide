#!/bin/bash
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
cd $DIR
git checkout -f master
git clean -xdff
git pull
./build.sh
