#!/bin/bash
set -ex

DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )

echo "Provide 'no-cache' to rebuild"
echo "Provide 'skip-compile' for testing decompression script"

NEOVIMREVISION=$(cat $DIR/NEOVIMREVISION)
echo "Building NEOVIM $NEOVIMREVISION"

SKIP_COMPILE=""
echo "$*" |grep -q 'skip-compile' && {
	SKIP_COMPILE='skip-compile'
}

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
    docker-compose run builder /tmp/vim/package $SKIP_COMPILE

	dest=$DIR/build/marcvim_installer_$rev.sh
	if [[ -f "$dest" ]]; then
		rm -f $dest
	fi
    mv $DIR/build/marcvim_installer.sh $dest
    docker-compose rm -f

    rm machine/Dockerfile
done
echo New marcvim installer is under build
