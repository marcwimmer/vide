"xmllint zum formatieren verwenden
"au FileType xml exe ":silent 1,$!xmllint --format --recover - 2>/dev/null"
map <leader>ft :silent exe "1,$!xmllint --format --recover - 2>/dev/null"<CR>

