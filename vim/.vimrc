" http://wwww.apaulodesign.com/vimrc.html
set shell=/bin/bash\ -l
set textwidth=79
set wrap
set nobackup
set visualbell
set ruler

set wrapscan    " allows search to wrap to top of document when the bottom has been hit
set incsearch   " highlights what you are searching for as you type
set hlsearch    " highlights all instance of the alst searched string
set ignorecase  " ignores case in search patterns
set smartcase   " don't ignore case when the search pattern has uppercase
set number      
set paste
set ruler

"bracket matching
set showmatch
set matchtime=3

set autoindent      " turn on auto-indenting (great for programers)
set copyindent      " when auto-indenting, use the indenting format of previous line
set cindent         " c-style indenting
set smartindent     "
set backspace=indent,eol,start
set tabstop=4       " width (in spaces) that a <tab> is displayed as
set shiftwidth=4    " width (in spaces) used in each step of autoindent (aswell as << and >>)
set expandtab
set softtabstop=4
set fileformat=unix 

" vundle
set nocompatible              " be iMproved, required
filetype off                  " required

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
"call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'
" Julia
Plugin 'JuliaEditorSupport/julia-vim'

" All of your Plugins must be added before the following line
call vundle#end()            " required

filetype plugin indent on
syntax on

filetype on
"highlighting
set nocursorline
syntax sync minlines=512
hi Search ctermbg=4

" Folding
"set foldmethod=syntax
"set foldnestmax=10
"set nofoldenable
"set foldlevel=1

au Filetype js,html,css
    \ setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2 

au Filetype python 
    \ setlocal  tabstop=4 shiftwidth=4 softtabstop=4
    \           expandtab smarttab
    \           autoindent smartindent
    \           fileformat=unix 

" allow the match paris operation (%) to work with '=' and ';'
au Filetype c,h,java,js setlocal mps+==:;

au Filetype java,js setlocal smartindent

au Filetype txt setlocal fo+=tn

" add yaml stuffs
au! BufNewFile,BufReadPost *.{yaml,yml,toml,json} set filetype=yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab

let s:extfname = expand("%:e")
if s:extfname ==? "f90" || s:extfname ==? "f" 
    let fortran_fress_source=1
    let fortran_fold=1
    let fortran_fold_conditionals=1
    let fortran_fold_multilinecomments=1
    let fortran_more_precise=1
    let fortran_dialect="elf"
"   au! BufRead.BufNewFile *.f90
    let b:fortran_do_enddo=1
    let fortran_have_tabs=1
    unlet! fortran_fixed_source
    unlet! fortran_have_tabs
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/
    setlocal tabstop=4
    setlocal shiftwidth=4
    setlocal softtabstop=4
elseif s:extfname ==? "f77"
    let fortran_fold=1
    let fortran_fold_conditionals=1
    let fortran_fold_multilinecomments=1
    let fortran_fixed_source=1
    let fortran_have_tabs = 1
    let fortran_do_enddo=1
    unlet! fortran_dialect
    unlet! fortran_fress_source
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal softtabstop=2
elseif s:extfname ==? "c" || s:extfname ==? "py"
    highlight OverLength ctermbg=red ctermfg=white guibg=#592929
    match OverLength /\%81v.\+/
endif

" Tell vim to remember certain things when we exit
"  '10  :  marks will be remembered for up to 10 previously edited files
"  "100 :  will save up to 100 lines for each register
"  :20  :  up to 20 lines of command-line history will be remembered
"  %    :  saves and restores the buffer list
"  n... :  where to save the viminfo files
set viminfo='10,\"100,:20,%,n~/.viminfo

autocmd BufReadPre SConstruct set filetype=python
autocmd BufReadPre SConscript set filetype=python
autocmd BufReadPost *.sconscript set filetype=python

autocmd BufNewFile * :write
au VimLeave * %bdelete

if has("autocmd")
  au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif
endif
