" If installed using Homebrew
"set rtp+=/usr/local/opt/fzf
set rtp+=~/.vim/bundle/fzf/bin

nnoremap <leader>ff :Files<CR> 
nnoremap <leader>fc :VideAg<CR> 
nnoremap <leader>fC :VideAgAll<CR> 
nnoremap <leader>fl :Lines<CR> 
nnoremap <leader>l :FZFMru<CR> 

let $DEFAULT_AG_IGNORES = '--ignore *.po'
let $DEFAULT_AG_DOWN = '~80%'

command! -bang -nargs=* VideAg call fzf#vim#ag(<q-args>, '$DEFAULT_AG_IGNORES', {'down': $DEFAULT_AG_DOWN})
command! -bang -nargs=* VideAgAll call fzf#vim#ag(<q-args>, '', {'down': $DEFAULT_AG_DOWN})

"original
"let g:fzf_files_options = '--preview "(coderay {} || cat {}) 2> /dev/null | head -'.&lines.'"'

let g:fzf_files_options = '--preview "(coderay {} || cat {}) 2> /dev/null"'
" [Buffers] Jump to the existing window if possible
let g:fzf_buffers_jump = 1

" [[B]Commits] Customize the options used by 'git log':
let g:fzf_commits_log_options = '--graph --color=always --format="%C(auto)%h%d %s %C(black)%C(bold)%cr"'
"let g:fzf_command_prefix = 'Fzf'

" ignore .gitignore and follow sumlinks
let $FZF_DEFAULT_COMMAND = 'ag -l -f --skip-vcs-ignores'

" When you press gv you vimgrep after the selected text
vnoremap <silent> gv :Ag y<C-r>"<CR>

noremap <silent> <C-]> :FufTagWithCursorWord!<CR>
let g:fuf_mrufile_maxItem = 2000
let g:fuf_mrufile_maxItemDir = 300
