#!/bin/bash
rm tmp/clone/* -Rf
docker-compose kill
if [[ "$1" == "DEBUG" ]]; then
    docker-compose build
else
    docker-compose build --no-cache
fi
docker-compose up

echo New marcvim installer is under build
