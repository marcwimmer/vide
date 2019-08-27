" YouCompleteMe - ansonsten gibt es Konflikt mit UltiSnips:
" http://www.alexeyshmalko.com/2014/youcompleteme-ultimate-autocomplete-plugin-for-vim/ 
let g:ycm_key_list_select_completion = ['<C-n>', '<Down>']
let g:ycm_key_list_previous_completion = ['<C-p>', '<Up>']
let g:ycm_autoclose_preview_window_after_completion=1

let g:ycm_auto_trigger=1 
let g:ycm_complete_in_comments = 1
let g:ycm_seed_identifiers_with_syntax = 1
let g:ycm_collect_identifiers_from_comments_and_strings = 1
let g:ycm_server_python_interpreter = '/usr/bin/python3'

nnoremap <leader>d :YcmComplete GoToDefinitionElseDeclaration<CR>


