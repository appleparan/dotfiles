set shell=/bin/bash\ -l
set tabstop=4
filetype plugin indent on
syntax on
filetype on

set autoindent
set cindent
set smartindent
set textwidth=79
set wrap
set nobackup
set visualbell
set ruler
set shiftwidth=4
set incsearch
set hlsearch
set number
set paste
set expandtab
set ruler
"bracket matching
set showmatch
set matchtime=3
colorscheme desert

"highlighting
"set cursorline
hi Search ctermbg=4

"Folding
"set foldmethod=syntax
"set foldnestmax=10
set nofoldenable
set foldlevel=1

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
    set tabstop=2
    set shiftwidth=2
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
    set tabstop=2
    set shiftwidth=2
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
