let mapleader=","

" leave insert mode by typing jk - really cool
inoremap jk <esc>
" Paste Command Shortcut
set nopaste "otherwise inoremap jk does not work
:set pastetoggle=<F7>

" Otherwise stupid ex-mode
nnoremap Q :quit!<CR>

" Fast Quit All
noremap <leader>qa: qall!<CR>
nnoremap <leader>w :w!<CR>

" New Tab:
nnoremap <leader>tn :tabnew<CR>
" Close Tab:
nnoremap <leader>tc :tabclose<CR>

" goto Next:
nnoremap gn :cnext<CR>
nnoremap gN :cprev<CR>

" toggle paste
set pastetoggle=<leader>p

" provide hjkl movements in Insert mode via the <Alt> modifier key
" did not work: 16.03.2015
"inoremap <D-h> <C-o>h
"noremap <D-j> <C-o>j
"noremap <D-k> <C-o>k
"noremap <D-l> <C-o>l" provide h
