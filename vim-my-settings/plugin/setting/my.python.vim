" Delete trailing white space on save, useful for Python and CoffeeScript ;)
func! DeleteTrailingWS()
  exe "normal mz"
  %s/\s\+$//ge
  exe "normal `z"
endfunc
autocmd BufWrite *.py :call DeleteTrailingWS()
autocmd BufWrite *.coffee :call DeleteTrailingWS()

" let g:python_host_prog  = '/usr/bin/python'
let g:pymode_python = 'python3'
let g:python3_host_prog = $NVIM_PYTHON3

" disable python2
" let g:loaded_python_provider = 0
