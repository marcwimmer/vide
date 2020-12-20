let g:vimhooks_async = 1
let g:vimhooks_debounce_wait = 2
let g:vimhook_bufferoutput = 0


" open sync destination file
function! g:OpenSyncDestinations()
python3 <<eof
import os
import vim
from pathlib import Path
FILENAME = '.vimhook.syncdestination'

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


map <leader>sd :call OpenSyncDestinations()<cr>
