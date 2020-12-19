" vim:fdm=marker
set nocompatible "we are using vim, not vi!
filetype off


set rtp+=~
"set rtp+=~/.config/nvim/bundle/Vundle.vim
"set rtp+=/home/marc/.config/nvim/bundle/Vundle.vim
set rtp+=$NVIM_BUNDLE_DIR/Vundle.vim

" set the runtime path to include Vundle and initialize
" using vim plug

let g:my_bundle_loader = $NVIM_BUNDLE_DIR

call vundle#begin($NVIM_BUNDLE_DIR)
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
if bundles_list.exists():
    bundles = [x for x in bundles_list.read_text().split("\n") if x and not x.startswith("#")]
    for bundle in bundles:
        vim.command("Plugin '%s'" % bundle)
def execute_file(filepath):
    if filepath.exists():
        for line in filepath.read_text().split("\n"):
            if not line or line.startswith('"'):
                continue
            vim.command(line)
execute_file(root_path / "_init")

#execute files from "my-init" directory
init_script_dir = root_path / "my-init"
if init_script_dir.is_dir():
    for filepath in init_script_dir.glob("*"):
        if str(filepath).endswith(".txt"):
            continue
        os.system('chmod a+x "{f}" && "{f}"'.format(f=filepath))

PYTHONEOF

" All of your Plugins must be added before the following line
call vundle#end()            " required
