#!/bin/bash

if [[ -n "LOCAL_UID" ]]; then
	sed -i "s/vide:x:1000:1000/vide:x:$LOCAL_UID:$LOCAL_UID/g" /etc/passwd
	chown "$LOCAL_UID" /home/vide/.cache -R
fi


gosu vide /start.sh "$@"
