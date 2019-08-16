"https://github.com/ggreer/the_silver_searcher
"let g:ackprg = 'ag --nogroup --nocolor --column'

"alternative:
"Which has the same effect but will report every match on the line.
let g:ackprg = "~/.vim/ag --vimgrep"
"
"Shortcut Tips
"e    to open file and close the quickfix window
"o    to open (same as enter)
"go   to preview file (open but maintain focus on ag.vim results)
"t    to open in new tab
"T    to open in new tab silently
"h    to open in horizontal split
"H    to open in horizontal split silently
"v    to open in vertical split
"gv   to open in vertical split silently
"q    to close the quickfix window
