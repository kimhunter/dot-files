" ### Core ###
syntax on

" UI settings
set ruler
" backspace=2 is legacy form of backspace=indent,eol,start — allows
" backspacing over autoindent, line breaks, and the start of an insert
set backspace=2
" Jump 5 lines when cursor reaches the screen edge while scrolling
set scrolljump=5
" Keep 5 lines of context visible above and below the cursor at all times
set scrolloff=5

" Editing settings
set autoindent
set shiftwidth=4
set tabstop=4
" Use shiftwidth for <Tab> at the start of a line; tabstop elsewhere
set smarttab
set expandtab

" Key mappings
" map! binds in both insert mode and command-line mode (not just insert)
" Exit insert mode quickly
map! jj <Esc>

"##############################
" Initialize register y to empty on startup
:let @y=''
" Blend matching-paren highlight into a black background, effectively hiding it
hi MatchParen ctermbg=black guibg=black

" vim -b : edit binary using xxd-format!
augroup Binary
  autocmd!
  autocmd BufReadPre  *.bin let &bin=1
  autocmd BufReadPost *.bin if &bin | %!xxd
  autocmd BufReadPost *.bin set ft=xxd | endif
  autocmd BufWritePre *.bin if &bin | %!xxd -r
  autocmd BufWritePre *.bin endif
  autocmd BufWritePost *.bin if &bin | %!xxd
  autocmd BufWritePost *.bin set nomod | endif
augroup END

" Smart Tab: at the start of a line, insert a real tab (indent); anywhere
" else, trigger keyword completion (<C-p>) — Tab doubles as a completion key
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction

"set backup
"set backupdir=~/.vim/backup

" Folding
"set foldmethod=indent
"set foldnestmax=2


" F3: insert current date inline at end of the current line
" (:read !date inserts output on a new line below; k moves up; J joins them)
:map <F3> :read !date<CR>kJ
" F4: insert a C file boilerplate (header comment block + main() skeleton)
map <F4> ggO/**************************************************<CR>* Brief Discription:<CR>* Written By:  <CR>* Date: <CR>* Version:<CR>**************************************************/<CR>#include <stdio.h><CR>int main(void)<CR>{<CR>return 0;<CR>}<Esc>

"##############################
" Toggle boolean-like words under cursor (yes↔no, true↔false, on↔off, etc.)
" Also cycles visibility modifiers (private→public→protected) and
" git rebase verbs (pick→squash→edit)
function s:ToggleYesNo()
  let w=expand("<cword>")
  if     w=="yes"        | let w="no"
  elseif w=="no"         | let w="yes"

  elseif w=="true"       | let w="false"
  elseif w=="false"      | let w="true"

  elseif w=="True"       | let w="False"
  elseif w=="False"      | let w="True"

  elseif w=="on"         | let w="off"
  elseif w=="off"        | let w="on"

  elseif w=="high"       | let w="low"
  elseif w=="low"        | let w="high"

  elseif w=="manual"     | let w="auto"
  elseif w=="auto"       | let w="manual"

  elseif w=="char"       | let w="int"
  elseif w=="int"        | let w="bool"
  elseif w=="bool"       | let w="char"

  elseif w=="private"    | let w="public"
  elseif w=="public"     | let w="protected"
  elseif w=="protected"  | let w="private"

  elseif w=="pick"       | let w="squash"
  elseif w=="squash"     | let w="edit"
  elseif w=="edit"       | let w="pick"
  else                   | let w=""
  endif
  if w!=""
    execute "normal! \"_ciw\<C-R>=w\<cr>\<Esc>b"
  endif
endfunction

nnoremap gy  :call <SID>ToggleYesNo()<cr>
" Wrap the word under cursor in double quotes
:nnoremap <Leader>" ciw""<Esc>P

"##############################
:source ~/.vim/leader.vim


"##############################
" Filetype-specific settings
augroup FiletypeSettings
  autocmd!
  " crontab: disable backup/writebackup so crontab -e can save the file safely
  autocmd FileType crontab set nobackup nowritebackup
  autocmd FileType ruby set expandtab sw=2 ts=2
  autocmd FileType make set noexpandtab
  autocmd FileType c source ~/.vim/c.vim
  " <Leader>; compiles and runs the current file
  autocmd FileType c noremap <Leader>; :w<CR>:!clang -o /tmp/a.out  %  && /tmp/a.out<CR>
  autocmd FileType cpp noremap <Leader>; :w<CR>:!clang++ -std=c++23 -o /tmp/a.out  %  && /tmp/a.out<CR>
  autocmd FileType py noremap <Leader>; :w<CR>:!python  %<CR>
  autocmd FileType ruby noremap <Leader>; :!ruby %<CR>
  autocmd FileType haskell noremap <Leader>; :w<CR>:!ghc -o /tmp/a.out % && /tmp/a.out<CR>

"######### DISABLED ############
"noremap ; :!cc % && ./a.out < ./answer.txt <CR>
" Compile + Run with leader ;
"  autocmd FileType c noremap ; :!gcc -pedantic-errors -ansi -Wbad-function-cast -Wmissing-declarations -Wmissing-prototypes -Wnested-externs -Wstrict-prototypes %  && ./a.out<CR>
"noremap ; :!fpc % ; read<CR>
"  autocmd FileType pascal,delphi noremap ; :!fpc %<CR>
"  autocmd FileType pascal,delphi set sw=2 ts=2
"#############################
augroup END

"##############################
" Type :Man (command) to see a man page in split view
" :Man 4 echo to go to section four of the man page
" \K to open man page for word under cursor
":source $VIMRUNTIME/ftplugin/man.vim
