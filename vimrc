"##############################
:let @y=''
" Syntax Highlighting -
syntax on   
set autoindent
set ruler
set backspace=2
hi MatchParen ctermbg=black guibg=black
       " vim -b : edit binary using xxd-format! 
        augroup Binary
          au!
          au BufReadPre  *.bin let &bin=1
          au BufReadPost *.bin if &bin | %!xxd 
          au BufReadPost *.bin set ft=xxd | endif
          au BufWritePre *.bin if &bin | %!xxd -r 
          au BufWritePre *.bin endif 
          au BufWritePost *.bin if &bin | %!xxd
          au BufWritePost *.bin set nomod | endif
        augroup END
" This function determines, wether we are on the start of the line text (then tab indents) or
" if we want to try autocompletion
func! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
" Show x,y Line number , line position in right hand corner
"set backup 
"set backupdir=~/.vim/backup

" 4 Spaces instead of TABSTOP
"set et 
set sw=4 ts=4
set smarttab 
set expandtab
  
"set foldmethod=indent
"set foldnestmax=2


" Save File
"map #2 :mkview<CR>:w<CR>
"map #3 :loadview<CR>
"map #4 0i    /**<CR> *<CR>*/
:map <F3> :read !date<CR>kJ
map <F4> ggO/**************************************************<CR>* Brief Discription:<CR>* Written By:  <CR>* Date: <CR>* Version:<CR>**************************************************/<CR>#include <stdio.h><CR>int main(void)<CR>{<CR>return 0;<CR>}<Esc>
map #7 :!osascript  ~/Scripts/refreshSafari.scpt<CR><CR>
:map #6 :set paste! 
"map #7 gUiw 
"map #7 :r!date '+\# \%a \%d/\%m/\%Y'<CR>
map #8 0i#<Esc>
"##############################
map! =sf scanf("%", );<Esc>2hi
map! =pf printf("%", );<Esc>2hi
map! jj <Esc>
"##############################

" {{{   PHP CONSTRUCTS 
" for loop
"map! =for for (i = 0; i ; i++)<Right> {<Up><Up><ESC>/ ;<CR>i
" if statement
"map! =if if () {<CR><CR>} else {<CR><CR>}<Up><Up><Up><Up><ESC>/)<CR>i
" }}}  PHP Constructs  
"##############################
function s:ToggleYesNo()
  let w=expand("<cword>")
  if     w=="yes"        | let w="no"
  elseif w=="no"         | let w="yes"
  elseif w=="true"       | let w="false"
  elseif w=="false"      | let w="true"
  elseif w=="on"         | let w="off"
  elseif w=="off"        | let w="on"
  elseif w=="high"       | let w="low"
  elseif w=="low"        | let w="high"
  elseif w=="manual"     | let w="auto"
  elseif w=="auto"       | let w="manual"
  elseif w=="const"      | let w="var"
  elseif w=="var"        | let w="const"
  elseif w=="procedure"  | let w="function"
  elseif w=="function"   | let w="procedure"
  elseif w=="char"       | let w="int"
  elseif w=="int"        | let w="bool"
  elseif w=="bool"       | let w="char"
  elseif w=="private"    | let w="public"
  elseif w=="public"     | let w="protected"
  elseif w=="protected"  | let w="private"
  elseif w=="mixed"      | let w="string"
  elseif w=="pick"       | let w="squash"
  elseif w=="squash"     | let w="edit"
  elseif w=="edit"       | let w="pick"
  else                   | let w=""
  endif
  if w!=""
    exec "normal! \"_ciw\<C-R>=w\<cr>\<Esc>b"
  endif
endfunc

nnoremap gy  :call <SID>ToggleYesNo()<cr>

"##############################
"##############################
" {{{ Auto commands
" Automatically reload .vimrc when changing
autocmd! bufwritepost .vimrc source %
" }}} Auto commands

au FileType crontab set nobackup nowritebackup
"##############################
" Map ; to run PHP parser check
au FileType php source ~/.vim/php/php.vim 
"au FileType php noremap ; :!php5 -l %<CR>
"au FileType php set ts=4 sw=4 noet    
au FileType ruby noremap ; :!ruby %<CR>
"##############################
"noremap ; :!fpc % ; read<CR>
au FileType pascal,delphi noremap ; :!fpc %<CR>
au FileType pascal,delphi set sw=2 ts=2 
"#############################
au FileType haskell noremap ; :w<CR>:!ghc -o /tmp/a.out % && /tmp/a.out<CR>
"##############################
"au FileType c noremap ; :!gcc -pedantic-errors -ansi -Wbad-function-cast -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wstrict-prototypes %  && ./a.out<CR>
au FileType c noremap ; :w<CR>:!clang -o /tmp/a.out  %  && /tmp/a.out<CR>
au FileType cpp noremap ; :!g++ -o /tmp/a.out  %  && /tmp/a.out<CR>
au FileType c source ~/.vim/c.vim
"au FileType c noremap gc I/*<Esc>A*/<Esc>
au FileType c set nosmarttab expandtab
au FileType ruby set expandtab sw=2 ts=2
au FileType make set noexpandtab
"noremap ; :!cc % && ./a.out < ./answer.txt <CR>
"##############################
" {{{ PhpDocumnetor Include section
"source ~/.vim/php-doc.vim
"inoremap <C-P> <ESC>:call PhpDocSingle()<CR>i
"nnoremap <C-P> :call PhpDocSingle()<CR>
"vnoremap <C-P> :call PhpDocRange()<CR>
" }}} PhpDocumnetor Include section

"##############################
" Type :Man (command) to see a man page in split view
" :Man 4 echo to go to section for of the man page
" \K to to open man page for word under cursor
":source $VIMRUNTIME/ftplugin/man.vim
:source ~/.vim/leader.vim

"##############################
" 4 Spaceed indents for c files
"au FileType php,c setlocal sw=4 smarttab expandtab
"au FileType delphi,pascal setlocal sw=2 smarttab expandtab
"##############################
" Jump 5 lines when running out of the screen
set scrolljump=5
" Indicate jump out of the screen when 3 lines before end of the screen
set scrolloff=3
