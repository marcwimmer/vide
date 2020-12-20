" vim:fdm=marker
set nocompatible "we are using vim, not vi!
filetype off


set rtp+=~
set rtp+=$PLUG_DIR/vim-plug
set rtp+=$PLUG_DIR/vim-my-settings
set rtp+=$PLUG_DIR/vim-odoo

" set the runtime path to include Vundle and initialize
" using vim plug

" let g:my_bundle_loader = $NVIM_BUNDLE_DIR

call plug#begin($NVIM_BUNDLE_DIR)

" let Vundle manage Vundle, required
python3 << PYTHONEOF
from pathlib import Path
import vim
import os
from os.path import expanduser
home = expanduser("~")
bundles_list = Path(home) / os.environ["VIDE_HOME"] / "plugins" / "vim-my-settings" / "bundles.list"
if bundles_list.exists():
    bundles = [x for x in bundles_list.read_text().splitlines() if x and not x.startswith("#")]
    for bundle in bundles:
        vim.command(f"Plug '{bundle}'")
	
PYTHONEOF

" All of your Plugins must be added before the following line
call plug#end()            " required

" Load settings
python3 << PYTHONEOF
root_path = Path(home) / os.environ["VIDE_HOME"] / "plugins" / "vim-my-settings"
for file in (root_path / "settings").glob("*.vim"):
    vim.command(f"so {file}")
PYTHONEOF
