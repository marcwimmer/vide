#!/bin/bash
rm tmp/clone/* -Rf
docker-compose kill
docker-compose build --no-cache
docker-compose up

echo New marcvim installer is under build
