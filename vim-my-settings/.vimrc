" vim:fdm=marker
set nocompatible "we are using vim, not vi!
filetype off

" set the runtime path to include Vundle and initialize
python << eof
# using vim plug
import os
AUTOLOAD_DIR = "/usr/local/share/nvim/runtime/autoload"
path = os.path.join(AUTOLOAD_DIR, 'plug.vim')
path = os.path.expanduser(path)
if not os.path.isfile(path):
    os.system('curl -fLo "{}" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'.format(path))
eof
 
call plug#begin("~/.vim/bundle")

" let Vundle manage Vundle, required

python << PYTHONEOF
import vim
import os
from os.path import expanduser
home = expanduser("~")
root_path = home + "/.vim/bundle/vim-my-settings"
if os.path.isfile(root_path + "/bundles.list"):
    with open(root_path + "/bundles.list") as f:
        bundles = [x for x in f.read().split("\n") if x]
        for bundle in bundles:
            if not bundle.startswith("#"):
                vim.command("Plug '%s'" % bundle)
def execute_file(filepath):
    if os.path.isfile(filepath):
        with open(filepath) as f:
            content = (f.read() or "").split("\n")
        for line in content:
            if not line or line.startswith("\""):
                continue
            vim.command(line)
execute_file(root_path + "/_init")

#execute files from "my-init" directory
init_script_dir = root_path + "/my-init"
if os.path.isdir(root_path + "/my-init"):
    for file in os.listdir(init_script_dir):
        if file.endswith(".txt"):
            continue
        filepath = init_script_dir + "/" + file
        os.system("chmod a+x \"%s\" && \"%s\"" %
            (filepath, filepath)
        )

PYTHONEOF

" All of your Plugins must be added before the following line
call plug#end()            " required
