"if enabled, then yanking does not work...
"iterm2: set applications allow clipboard access to NO
"set clipboard=unnamed
"set clipboard=unnamed

" to avoid ssh from osx with quartz error: Error: target STRING not available
let g:yankring_clipboard_monitor=0


"Copy & paste to system clipboard with <Space>p and <Space>y:
"from: http://sheerun.net/2014/03/21/how-to-boost-your-vim-productivity/
"vmap <Leader>y "+y
"vmap <Leader>d "+d
"nmap <Leader>p "+p
"nmap <Leader>P "+P
"vmap <Leader>p "+p
"vmap <Leader>P "+P
