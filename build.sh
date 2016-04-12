#!/bin/bash
docker-compose kill
docker-compose build
docker-compose up

echo New marcvim installer is under build
