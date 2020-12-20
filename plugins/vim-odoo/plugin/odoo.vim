command! OdooUpdateView call OdooExecute('update_view_in_db', "")
command! OdooUpdateModuleFile call OdooExecute('update_module_file', '')
command! OdooUpdateModule call OdooExecute('update_module', '')
command! OdooUpdateModuleFull call OdooExecute('update_module_full', '')
command! OdooExportLangs call OdooExecute('export_langs', '')
command! OdooQuickRestart call OdooExecute('quick_restart', '')
command! OdooRestart call OdooExecute('restart', '')
command! OdooMakeModule call OdooMakeModule()
command! OdooGotoInheritedViewSplit call OdooGotoInheritedView('vnew')
command! OdooGotoInheritedViewTab call OdooGotoInheritedView('tabnew')
command! OdooRunTest call OdooExecute('run_test', '')
command! OdooRunLastTest call OdooExecute('run_last_test', '')
command! OdooCompleteUpdateCache call OdooExecute('update_cache', '')
autocmd BufWritePost * call OdooExecute('filechanged', expand('<afile>:p'))
"------------------------------------------------------------------------------


command! OdooFzf call OdooFzfSearch()
command! -bang -nargs=* AgOdoo call fzf#vim#ag(<q-args>, '', {'down': '~40%'})

function _OdooLoadPlugins()
" Absolute path of script file with symbolic links resolved:
let s:path = resolve(expand('<sfile>:p'))
python3 << PYTHONEOF
def do_reload(module, force=False):
    if os.getenv("RELOAD_ODOO_MODULES", "") == "1" or force:
        # print("RELOAD_ODOO_MODULES set - reloading odoo now")
        import importlib
        importlib.reload(module)
from pathlib import Path
import os
import sys
import inspect, os
import vim
from os.path import expanduser
dir = Path(vim.eval("resolve(expand('<sfile>:p'))")).parent
dir = Path(os.environ['VIDE_HOME']) / 'plugins' / 'vim-odoo' / 'plugin'
if not dir.exists():
    raise Exception(f"Not found: {dir}")
sys.path.append(str(dir))
import odoo
do_reload(odoo)
PYTHONEOF
endfunction

function! OdooFzfSearch()
call _OdooLoadPlugins()
python3 << PYTHONEOF
err = ''

load = odoo.execute_from_vim(vim, "just_load", False)

p = Path(os.getcwd())
while len(p.parts) > 1:
    AST_FILE = p / '.odoo.ast'
    if AST_FILE.exists():
        vim.command('silent let g:AST_FILE = "{}"'.format(AST_FILE))
        break
    p = p.parent
PYTHONEOF

call fzf#run(fzf#wrap({'source': 'cat ' . g:AST_FILE, 'sink': funcref('OdooOpenFzfLine'), 'down': '75%' }))
"call fzf#run(fzf#wrap({'source': g:AST_FILE, 'sink': funcref('OdooOpenFzfLine'), 'down': '75%' }))
endfunction



function! OdooExecute(cmd, filepath)
" Executes from administration directory the desired script.

let current_buff = bufnr("%")
call _OdooLoadPlugins()
let g:LAST_ERROR=''
python3 <<EOF
import vim, os, subprocess
from pathlib import Path
if filepath:
    path = os.path.dirname(vim.eval('a:filepath'))
else:
    path = None
if not path or not Path(path).exists():
    vim.command("let s:filepath=''")
else:
    vim.command("let s:filepath='{}'".format(path))
EOF
if empty(s:filepath)
else
    " auto save current file
    " javascript files: a new buffer somehow opened
    if a:cmd != 'filechanged'
        execute ":w"
    endif
endif
    

python3 << PYTHONEOF

cmd = vim.eval("a:cmd")
filepath = vim.eval("a:filepath")
filepath = filepath or vim.current.buffer.name
err = ''
odoo.execute_from_vim(vim, cmd, filepath)

PYTHONEOF

endfunction


function! OdooMakeModule()
    cal _OdooLoadPlugins()
    " called by <leader>m usually
    let file = vimfiler#get_file(b:vimfiler)
    let path = file.action__path
python3 <<EOF
import vim, os, subprocess
from pathlib import Path
path = os.path.dirname(vim.eval('path'))
vim.command("silent let path = '%s'" % path)
EOF
    let name = input("Please type the name of the new module (path: " . path . "): ")
    if name == ''
        return
    endif
python3 <<EOF
path = Path(vim.eval('path'))
if not path.is_dir():
    path = str(path.parent)
odoo.execute_from_vim(vim, 'make_module', parent_path=str(path), module_name=vim.eval('name'))
vim.command("call vimfiler#force_redraw_screen()")
EOF

echo("Module " . name . " created")
endfunction

"###########################################################################
"  Vim Omnicompletion Template using Python
"  Author: Marc-Christian Wimmer (thank's to Sean Reifschneider), 2012

function! OdooGotoInheritedView(newcommand)
" newcommand like vnew or tabnew
call _OdooLoadPlugins()
python3 << PYTHONEOF

#  @@@ Change this to 2 if you have problems and watch syslog
#  set to values greater than 1 to get debugging information logged to syslog
debug_level = 2

from odoo import goto_inherited_view
import vim

filepath = vim.current.buffer.name
line, nbyte = vim.current.window.cursor  # line ist 1 basiert

filepath, line = goto_inherited_view(vim, filepath, line, vim.current.buffer)

if filepath and line:
    newcommand = vim.eval("a:newcommand")
    vim.command(":" + newcommand + " " + str(filepath))
    vim.command(":%s" % line)

PYTHONEOF
endfunction


function! OdooFzf()
    call _OdooLoadPlugins()
python3 << PYTHONEOF
from odoo import parser_module
filepath = parser_module().plaintextfile()
vim.command("let g:filepath=%s" % filepath)

PYTHONEOF

endfunction

function! OdooOpenFzfLine(line)
    call _OdooLoadPlugins()
python3 << PYTHONEOF
from odoo import __load_modules
from odoo import config
from odoo import parser_module
CUSTOMS = config().current_customs()
if not CUSTOMS:
    vim.command("echo('No Customs Found')")
else:
    line = vim.eval("a:line")
    filepath, lineno = line.split(":::")[1].split("::")
    filepath = parser_module().try_to_get_filepath(filepath)
    if filepath and line:
        vim.command(":tabnew %s" % filepath)
        vim.command(":%s" % lineno)
PYTHONEOF
endfunction
