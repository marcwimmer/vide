" vim:fdm=marker
set nocompatible "we are using vim, not vi!
filetype off
let mapleader = "," " map leader to comma; must be here, so that regarded at loading plugins

set rtp+=$PLUG_DIR/vim-plug

call plug#begin($NVIM_BUNDLE_DIR)

" let vim-plug manage plugins
python3 << PYTHONEOF
from pathlib import Path
import vim
import os
from os.path import expanduser
bundles_list = Path(expanduser("~")) / os.environ["VIDE_HOME"] / "bundles.list"
if bundles_list.exists():
    bundles = [x for x in bundles_list.read_text().splitlines() if x and not x.startswith("#")]
    for bundle in bundles:
        bundle = bundle.replace("$VIDE_HOME", os.environ['VIDE_HOME'])
        bundle = bundle.replace("$NVIM_BUNDLE_DIR", os.environ['NVIM_BUNDLE_DIR'])
        vim.command(f"Plug '{bundle}'")
	
PYTHONEOF


" All of your Plugins must be added before the following line
call plug#end()            " required

" Load settings
python3 << PYTHONEOF
for file in (Path(expanduser("~")) / os.environ["VIDE_HOME"] / "settings").glob("*.vim"):
    vim.command(f"so {file}")
PYTHONEOF
