#!/bin/bash
set -ex

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

echo "Provide 'no-cache' to rebuild"

NEOVIMREVISION=$(cat $DIR/NEOVIMREVISION)
echo "Building NEOVIM $NEOVIMREVISION"

for rev in $(ls $DIR/revisions);
do
    echo building $rev
    cp $DIR/revisions/$rev machine/Dockerfile
    sed -i "s|__NEOVIMREVISION__|$NEOVIMREVISION|g" machine/Dockerfile

    rm tmp/clone/* -Rf || true
    docker-compose kill
    if [[ "$1" == "NO-CACHE" || "$1" == "no-cache" ]]; then
        docker-compose build --no-cache
    else
        docker-compose build 
    fi
    docker-compose up

    cp $DIR/build/marcvim_installer.sh $DIR/build/marcvim_installer_$rev.sh
    docker-compose rm -f

    rm machine/Dockerfile
done
echo New marcvim installer is under build
