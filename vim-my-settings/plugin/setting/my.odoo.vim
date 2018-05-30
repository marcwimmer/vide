"Fuf OpenERP


map <leader>fo :OdooFzf<cr>
map <leader>ff :OdooFiles<cr>
map <leader>fF: :OdooFileContents<CR> 

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
map <leader>customs :OdooSwitchCustomsAndDb<cr>


autocmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings()
    nmap <buffer> <leader>m :call OdooMakeModule()<CR>
endfunction
