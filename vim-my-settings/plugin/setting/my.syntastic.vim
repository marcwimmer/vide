
" Lines taken from syntastic self:
set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*

" let g:syntastic_debug = 3
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 0
let g:syntastic_check_on_wq = 0

" Install node.js and THEN with G Option:
" sudo npm install eslint -g
" let g:syntastic_javascript_checkers = ['eslint']
" initialisierung eslint --init
" eslint braucht ne package.json - jshint ist moderner als jslint angeblich
" nicht so gut wie eslint aber gut genug
let g:syntastic_javascript_checkers = ['jshint']

"install on mac with sudo pip install flake8
" for python2 check: sudo pip uninstall flake8; sudo pip2 install flake8
" (works!)
let g:syntastic_python_checkers = ['flake8']
let g:syntastic_python_flake8_args = '--ignore="F401,E501,E302,E261,E701,E241,E126,E127,E128,W801"'
let g:syntastic_python_python_exec = '/usr/bin/python3'
"let g:pep8_ignore="E501,W601"

nnoremap <leader>ss :SyntasticToggleMode<CR>

