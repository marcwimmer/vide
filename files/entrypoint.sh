#!/bin/bash
set -e

HOME=/home/vide


if [[ -n "$LOCAL_UID" && "$LOCAL_UID" != "0" ]]; then
	sed -i "s/vide:x:1000:1000/vide:x:$LOCAL_UID:$LOCAL_UID/g" /etc/passwd
	chown "$LOCAL_UID" "$HOME/.cache" -R
    mkdir -p "$HOME/.local"
	chown "$LOCAL_UID" $HOME/.local -R
    mkdir "$HOME/.npm"
    chown "$LOCAL_UID" "$HOME/.npm"
    touch $HOME/yankring_history_v2.txt
    chown "$LOCAL_UID" $HOME/yankring_history_v2.txt
    exec gosu vide /start.sh "$@"
else
    	exec /start.sh "$@"
fi


