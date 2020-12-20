#!/bin/bash
echo
echo Setup VIDE
echo

echo 
echo NEOVim must be installed

echo "Replacing current neovim init file with this (ctrl+c to abort)"
read

mkdir -p ~/.config/nvim
rm ~/.config/nvim/init.vim 2>/dev/null|| true
ln -s "$(pwd)/bin/init.vim"  ~/.config/nvim/init.vim

pip3 install -r requirements3.txt

nvim +'PlugInstall --sync' +qa
