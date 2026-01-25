""" Whitespace: 4 spaces, no tabs """
set tabstop=4
set shiftwidth=4
set expandtab
set nosmarttab

""" Use C-style auto-indentation """
set cindent

" Append semicolon to end of line (if not already ending with ; { } or tab)
noremap \ :s/\([^\t{};]\)$/\1;/<cr>

" Tab key: indent at line start, otherwise trigger keyword completion
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

func! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

" Snippets: type abbreviation in insert mode to expand
map! =sf scanf("%", );<Esc>2hi
map! =pf printf("%", );<Esc>2hi
map! =for for(i=0; ; i++) {<CR>}<Up><Esc>8li
