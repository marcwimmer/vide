"Voom ist sowas wie taglist aber besser :)
"Voom automatisch mit Oeffnen von Dateien initialisieren

function VoomIt(markup)
    try
        :VoomQuitAll
    catch
    endtry

    try
        :execute(":Voom ".a:markup)
    catch
    endtry
endfunction

let g:voom_tree_width = 60
let g:voom_tree_placement = 'right'

"utocmd BufWinEnter *.tex :call VoomIt("latex")
"utocmd BufWinEnter *.py :call VoomIt("python")
"autocmd BufWinEnter *.html :call VoomIt("python")
"autocmd BufWinEnter *.xml :call VoomIt("xml")
map <leader>k :VoomToggle python<CR>

"ansonsten mueste man mit :Voom python z.B. fuer python starten
"tipps von
"http://blog.florianheinle.de/post/30117459921/vim-outliner
