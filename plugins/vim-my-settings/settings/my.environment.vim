syntax on
set encoding=utf-8
set history=1000
set autoindent
filetype indent plugin on
set nobackup
set nowritebackup
set noswapfile
let MRU_Max_Entries=500
set noexpandtab 
set tabstop=4
set softtabstop=4
set shiftwidth=4
set smarttab "When on, a <Tab> in front of a line inserts blanks according to 'shiftwidth'.  'tabstop' or 'softtabstop' is used in other places.  A <BS> will delete a 'shiftwidth' worth of space at the start of the line.  
set nu
set ruler    " bottom left line info
"set textwidth=80       " break lines when line length increases


au FileType python setlocal expandtab
au FileType yaml setlocal expandtab
