"to have Vim jump to the last position when                                                       
" reopening a file
":autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g`\"" | endif
"
"ERROR in NEOVIM
" set viminfo='10,\"100,:20,%,n~/.viminfo


" Only do this part when compiled with support for autocommands
   if has("autocmd")
     " When editing a file, always jump to the last cursor position
     autocmd BufReadPost *
     \ if line("'\"") > 0 && line ("'\"") <= line("$") |
     \   exe "normal g'\"" |
     \ endif
   endif
