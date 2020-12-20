" vim:fdm=marker
set nocompatible "we are using vim, not vi!
filetype off


set rtp+=~
set rtp+=$PLUG_DIR/vim-plug

" set the runtime path to include Vundle and initialize
" using vim plug

" let g:my_bundle_loader = $NVIM_BUNDLE_DIR

call plug#begin($NVIM_BUNDLE_DIR)
Plugin 'VundleVim/Vundle.vim'

" let Vundle manage Vundle, required
python3 << PYTHONEOF
from pathlib import Path
import vim
import os
from os.path import expanduser
home = expanduser("~")
root_path = Path(home) / os.environ["NVIM_BUNDLE_DIR"] / "vim-my-settings"
bundles_list = root_path / "bundles.list"
raise Exception(bundles_list)
if bundles_list.exists():
    bundles = [x for x in bundles_list.read_text().split("\n") if x and not x.startswith("#")]
    for bundle in bundles:
        vim.command("Plugin '%s'" % bundle)
	
PYTHONEOF

" All of your Plugins must be added before the following line
call plug#end()            " required
