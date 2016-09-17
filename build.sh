#!/bin/bash
set -e

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

for rev in $(ls $DIR/revisions);
do
    echo building $rev
    cp $DIR/revisions/$rev machine/Dockerfile

    rm tmp/clone/* -Rf || true
    docker-compose kill
    if [[ "$1" == "DEBUG" ]]; then
        docker-compose build
    else
        docker-compose build --no-cache
    fi
    docker-compose up

    cp $DIR/build/marcvim_installer.sh $DIR/build/marcvim_installer_$rev.sh

done
echo New marcvim installer is under build
