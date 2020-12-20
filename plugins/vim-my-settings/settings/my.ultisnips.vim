" Make ,se to edit snippets
map <leader>se :UltiSnipsEdit<cr>

"using supertab and youcompleteme
"let g:UltiSnipsSnippetDirectories=[expand("~/.vim/UltiSnips")]
let g:UltiSnipsSnippetDirectories=[expand($NVIM_ULTISNIPS_DIR)]
let g:SuperTabDefaultCompletionType = '<C-n>'
let g:UltiSnipsExpandTrigger="<tab>"
"let g:UltiSnipsJumpForwardTrigger="<c-j>"
"let g:UltiSnipsJumpBackwardTrigger ="<c-k>"

let g:UltiSnipsJumpForwardTrigger="<tab>"                                       
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"
