"tell the term has 256 colors
set t_Co=256

" can be dark/light for papercolor
set background=light
" :silent! colorscheme lucius
:silent! colorscheme PaperColor

" highlight current line
:hi CursorLine   cterm=NONE ctermbg=darkred ctermfg=white guibg=darkred guifg=white


map <Leader>bg :let &background = ( &background == "dark"? "light" : "dark" )<CR>
