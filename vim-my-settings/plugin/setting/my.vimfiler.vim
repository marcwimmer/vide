:let g:vimfiler_as_default_explorer = 1
nnoremap - :VimFilerBufferDir<CR>

 " Enable file operation commands.
" call vimfiler#custom#profile('default', 'context', { 'safe' : 0, 'edit_action': 'tabopen' })
" Open in new tab
call vimfiler#custom#profile('default', 'context', { 'safe' : 0 })
"nnoremap <silent> <buffer> <expr> - call vimfiler#do_action('split')


function! VimFilerSearchInDir(cmd)
    " allow with ,ff ,fc to search files of contents in directory
    let file = vimfiler#get_file(b:vimfiler)
    let path = file.action__path
    echo("Searching in " . path)
python3 <<eof
import vim
path = vim.eval("path") 
path = os.path.dirname(path)
vim.command("chdir {}".format(path))
vim.command(":" + vim.eval('a:cmd'))
eof
endfunction
"
autocmd FileType vimfiler call s:vimfiler_my_settings()
function! s:vimfiler_my_settings()
    nmap <buffer> <leader>ff :call VimFilerSearchInDir('Files')<CR>
    nmap <buffer> <leader>fc :call VimFilerSearchInDir('VideAg')<CR>
    nmap <buffer> <leader>fC :call VimFilerSearchInDir('VideAgAll')<CR>
    nmap <silent><buffer> - <Plug>(vimfiler_smart_h)
    nmap <silent><buffer> <BS> <Plug>(vimfiler_close)
    nmap <buffer>T  vimfiler#do_action('tabopen')<CR>
endfunction
