#!/bin/bash
echo
echo Setup VIDE
echo

echo 
echo NEOVim must be installed
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
pip3 install -r "$DIR/requirements3.txt"

nvim +'PlugInstall --sync' +qa
python3 ~/.config/vide/bundles/YouCompleteMe/install.py
