" Make ,se to edit snippets
map <leader>se :UltiSnipsEdit<cr>

"http://stackoverflow.com/questions/14896327/ultisnips-and-youcompleteme {{{
" make YCM compatible with UltiSnips (using supertab)
let g:SuperTabDefaultCompletionType = '<C-n>'

let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<c-j>"
let g:UltiSnipsJumpBackwardTrigger ="<c-k>"

"Here UltiSnips is bound to a different combination (Ctrl-n), 
"but then that combination is bound to tab through SuperTab. 
"UltiSnips and SuperTab play nice together, so you can then 
"jsut bind UltiSnips to tab directly and everything will 
"work out.
"}}}
