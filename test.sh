#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Requires 14.04|16.04 as argument"
    exit -1
fi

docker-compose up marcvimbuilder
echo ''
echo ''
echo ''
echo 'Install marcvim from /build/marcvim_installer.sh'
echo ''
echo ''
echo ''
docker-compose run testvim_$1 bash
