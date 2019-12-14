"xmllint zum formatieren verwenden
"au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
"
function FuncLintXml()
    :let l:savepos = getpos('.')
    :silent exe "1,$!xmllint --format --recover - 2>/dev/null"
    :call setpos('.', l:savepos)
endfunction
map <leader>ft :call FuncLintXml()<CR>
