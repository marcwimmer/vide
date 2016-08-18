#!/bin/bash

if [[ -z "$1" ]]; then
    echo "Requires 14.04|16.04 as argument"
    exit -1
fi

docker-compose up marcvimbuilder
docker-compose run testvim$1 bash
