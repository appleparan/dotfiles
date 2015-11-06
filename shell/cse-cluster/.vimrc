" http://wwww.apaulodesign.com/vimrc.html
set shell=/bin/bash\ -l
set textwidth=79
set wrap
set nobackup
set noswf
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

" for pathgen
execute pathogen#infect()


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

" For html
let html_use_css = 1
" tabstop for html
au Filetype xhtml,html,htm,php,xml setlocal tabstop=2
" (et) expand tabs to spaces (use :retab to redo entire file)
au Filetype xhtml,html,htm,php,xml setlocal shiftwidth=2 
" (sts) makes spaces feel like tabs (like deleting)
au Filetype xhtml,html,htm,php,xml setlocal softtabstop=2

" allow the match paris operation (%) to work with '=' and ';'
au Filetype c,h,java,js setlocal mps+==:;

au Filetype java,js setlocal smartindent


au Filetype txt setlocal fo+=tn

let s:extfname = expand("%:e")
if s:extfname ==? "f90"
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
    setlocal tabstop=2
    setlocal shiftwidth=2
    setlocal softtabstop=2
elseif s:extfname ==? "f77" || s:extfname ==? "f" 
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

function! ResCur()
  if line("'\"") <= line("$")
    normal! g`"
    return 1
  endif
endfunction

augroup resCur
  autocmd!
  autocmd BufWinEnter * call ResCur()
augroup END

nnoremap <F4> :set invpaste paste?<CR>

autocmd BufReadPre SConstruct set filetype=python
autocmd BufReadPre SConscript set filetype=python
autocmd BufReadPost *.sconscript set filetype=python
