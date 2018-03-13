" removes pudb.set_trace() and import pudb
command! TraceClear normal! gg<CR>:g/import pudb/d<CR>:g/pudb.set_trace()/d<CR>:g/from pudb import set_trace/d<CR>:g/set_trace()/d<CR>

noremap <leader>ct :TraceClear<cr>
