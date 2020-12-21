" open sync destination file
function! g:OpenSyncDestinations()
python3 <<eof
import os
import vim
from pathlib import Path
FILENAME = '.syncdestination'

def editfile():
    path = Path(os.getcwd())
    while path.parent != path:
        test = path / FILENAME 
        if test.exists():
            vim.command(f":e {test}")
            return True
        path = path.parent

if not editfile():
    path = Path(os.getcwd())
    while path.parent != path:
        test = path / '.git'
        if test.exists():
            (path / FILENAME).write_text("")
            vim.command(f":e {path / FILENAME}")
        path = path.parent

eof

endfunction


python3 <<eof
from pathlib import Path
import os
import shutil

filepath = Path(os.path.expanduser("~")) / ".vimhooks" / "bufwritepost.vimhook.py"
if not filepath.parent.exists() :
    filepath.parent.mkdir(exist_ok=True, parents=True)
if filepath.exists():
    filepath.unlink()

# TODO get path of current vim script
shutil.copy(
    Path(os.environ['VIDE_HOME']) / 'plugins' / 'syncdestination' / 'bufwritepost.vimhook.py',
    filepath,
)


eof

map <leader>sd :call OpenSyncDestinations()<cr>
