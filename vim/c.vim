set tabstop=4
set shiftwidth=4
set expandtab
set nosmarttab

au FileType c :set cindent
noremap \ :s/\([^\t{};]\)$/\1;/<cr>

set dictionary-=/Users/kim/.vim/php/functionlist.txt dictionary+=/Users/kim/.vim/php/functionlist.txt
" Use the dictionary completion
set complete-=k complete+=k
inoremap <tab> <c-r>=InsertTabWrapper()<cr>

func! InsertTabWrapper() 
	let col = col('.') - 1 
	if !col || getline('.')[col - 1] !~ '\k' 
		return "\<tab>" 
	else 
		return "\<c-p>" 
	endif 
endfunction 

map! =sf scanf("%", );<Esc>2hi
map! =pf printf("%", );<Esc>2hi
"map! =for for($i=0; ; i++<Esc>A {<Up><ESC>10l
"map! =for for($i=0; ; i++)<Right>{<CR>}<Up><ESC>9l

" if statement
"map! =if if (<Esc>A {<Esc>ddA else {<Esc>dd<Up><Up>4li
