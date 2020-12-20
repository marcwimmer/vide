#!/bin/bash
set -e
DIR=$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )
echo Setup VIDE
echo NEOVim must be installed
echo Installing vim-plug
mkdir -p ~/.config/nvim/autoload
wget -O ~/.config/nvim/autoload/plug.vim https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
#curl -fLo ~/.config/nvim/autoload https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
echo "Do:"
echo "pip3 install -r \"$DIR/requirements3.txt\""
echo "bin/vide +'PlugInstall --sync' +qa"
echo "python3 ~/.config/vide/bundles/YouCompleteMe/install.py"
