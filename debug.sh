#!/bin/bash
set -x
set -e
echo "Not building complete machine; just compiling package to test decompression script"
docker-compose kill || true
docker-compose build
docker-compose -f docker-compose.yml -f docker-compose.debug.yml up

echo New marcvim installer is under build
