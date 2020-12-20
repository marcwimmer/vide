let g:rooter_silent_chdir = 0
let g:rooter_cdm_cmd="lcd"

"disable mapping key <leader>cd
let g:rooter_disable_map = 1
"let g:rooter_patterns = ['Rakefile', '.git/']
let g:rooter_patterns = ['.odoogit', '.git/']
map <silent> <unique> <Leader>cd <Plug>RooterChangeToRootDirectory

let g:rooter_silent_chdir = 1
