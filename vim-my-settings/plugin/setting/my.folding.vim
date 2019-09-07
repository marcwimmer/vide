"folding settings
set foldmethod=syntax   "fold based on syntax
set foldnestmax=9       "deepest fold is 3 levels
set foldlevelstart=99   "expand all at start
set nofoldenable       "dont fold by default
let javaScript_fold=1
let python_fold=1
set foldcolumn=4

"For Plugin jelera/vim-javascript-syntax
au FileType javascript call JavaScriptFold()

"Folding toggle with space - cool
"nnoremap <space> za
"vnoremap <space> zf

