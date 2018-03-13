#!/bin/bash

if [[ ! -f ~/.vim/UltiSnips/all.snippets ]]; then
	cp /opt/clone_UltiSnips ~/.vim/UltiSnips -r
fi

/usr/bin/vim "$@"
