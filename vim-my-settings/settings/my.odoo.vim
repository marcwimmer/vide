"Fuf OpenERP


map <leader>fo :OdooFzf<cr>
"map <leader>ff :OdooFiles<cr>

map <leader>uc :OdooCompleteUpdateCache<cr>
map <leader>gi :OdooGotoInheritedViewSplit<cr>
map <leader>gI :OdooGotoInheritedViewTab<cr>
map <leader>umf :OdooUpdateModuleFile<cr>:e!<cr>
map <leader>um :OdooUpdateModule<cr>
map <leader>uM :OdooUpdateModuleFull<cr>
map <leader>rt :OdooRunTest<cr>
map <leader>rT :OdooRunLastTest<cr>
map <leader>or :OdooQuickRestart<cr>
map <leader>oR :OdooRestart<cr>
map <leader>uv :OdooUpdateView<cr>
map <leader>el :OdooExportLang<cr>
map <leader>customs :OdooSwitchCustomsAndDb<cr>


autocmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings()
    nmap <buffer> <leader>m :call OdooMakeModule()<CR>
endfunction

" open manifest file
function! g:OpenOdooFile(filename, search_upward_form_manifest)
let path=expand('%:p')
python3 <<eof
import os
import vim
from pathlib import Path
path = Path(vim.eval('path'))
search_upward_form_manifest = int(vim.eval('a:search_upward_form_manifest'))

search_file = vim.eval('a:filename') if not search_upward_form_manifest else '__manifest__.py'

found = False
while path.parent != path:
    test = path / vim.eval('a:filename')
    if test.exists():
        if not search_upward_form_manifest:
            vim.command(f":e {test}")
        found = True
        break
    path = path.parent

if found and search_upward_form_manifest:
    findings = list(path.glob(f"**/{vim.eval('a:filename')}"))
    if findings:
        abs_path = path / findings[0]
        print(abs_path)
        vim.command(f":e {abs_path}")

eof
endfunction

function! g:OdooPutCurrentModuleName()
let path=expand('%:p')
let l:result=''
python3 <<eof
import os
import vim
from pathlib import Path
path = Path(vim.eval('path'))
mode = vim.eval('mode()')
while path.parent != path:
    test = path / '__manifest__.py'
    if test.exists():
        module_name = test.parent.name
        if mode == 'i':
            vim.command(f"let l:result='{module_name}'")
        else:
            vim.command(f":normal i{module_name}")
        break
    path = path.parent
eof
return l:result
endfunction


map <leader>gmf :call OpenOdooFile('__manifest__.py', 0)<cr>
map <leader>gMf :call OpenOdooFile('MANIFEST', 0)<cr>
map <leader>gma :call OpenOdooFile('ir.model.access.csv', 1)<cr>
map <leader>om :call OdooPutCurrentModuleName()<cr>
inoremap <silent> <leader>om <C-R>=OdooPutCurrentModuleName()<cr>
