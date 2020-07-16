let g:vimhooks_async = 1
let g:vimhooks_debounce_wait = 2
let g:vimhook_bufferoutput = 0


" open sync destination file
function! g:OpenSyncDestinations()
python3 <<eof
import os
import vim
from pathlib import Path
path = Path(os.getcwd())

while path.parent != path:
    test = path / '.vimhook.syncdestination'
    if test.exists():
        vim.command(f":e {test}")
        break
    path = path.parent

eof

endfunction


map <leader>sd :call OpenSyncDestinations()<cr>
