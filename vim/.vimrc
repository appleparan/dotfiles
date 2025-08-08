" Modern Vim Configuration for Python, Go, Rust, and Node.js Development
" Optimized for productivity and modern development workflows

" =============================================================================
" Plugin Management with vim-plug
" =============================================================================
" Auto-install vim-plug if not present
if empty(glob('~/.vim/autoload/plug.vim'))
  silent !curl -fLo ~/.vim/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" Essential plugins
Plug 'tpope/vim-sensible'           " Sensible defaults
Plug 'tpope/vim-surround'           " Surrounding text objects
Plug 'tpope/vim-commentary'         " Easy commenting
Plug 'tpope/vim-fugitive'           " Git integration
Plug 'tpope/vim-repeat'             " Repeat plugin commands

" File management and fuzzy finding
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Status line and UI
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'

" Language-specific plugins
" Python
Plug 'vim-python/python-syntax'
Plug 'Vimjas/vim-python-pep8-indent'
Plug 'jeetsukumaran/vim-pythonsense'

" Go
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }

" Rust
Plug 'rust-lang/rust.vim'

" JavaScript/TypeScript/Node.js
Plug 'pangloss/vim-javascript'
Plug 'leafgarland/typescript-vim'
Plug 'MaxMEllon/vim-jsx-pretty'

" Syntax highlighting and formatting
Plug 'sheerun/vim-polyglot'
Plug 'dense-analysis/ale'
Plug 'editorconfig/editorconfig-vim'

" Additional productivity plugins
Plug 'jiangmiao/auto-pairs'
Plug 'preservim/tagbar'
Plug 'airblade/vim-gitgutter'
Plug 'terryma/vim-multiple-cursors'

call plug#end()

" =============================================================================
" Basic Settings
" =============================================================================
set nocompatible
filetype plugin indent on
syntax on

" UI and appearance
set number
set cursorline
set showmatch
set ruler
set laststatus=2
set showcmd
set wildmenu
set wildmode=longest:full,full
set scrolloff=8
set sidescrolloff=8

" Search settings
set incsearch
set hlsearch
set ignorecase
set smartcase
set wrapscan

" Indentation and tabs
set autoindent
set smartindent
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set shiftround

" File handling
set autoread
set backup
set backupdir=~/.vim/backup//
set directory=~/.vim/swap//
set undofile
set undodir=~/.vim/undo//
set encoding=utf-8
set fileencoding=utf-8

" Create backup directories if they don't exist
if !isdirectory($HOME."/.vim/backup")
    call mkdir($HOME."/.vim/backup", "p", 0700)
endif
if !isdirectory($HOME."/.vim/swap")
    call mkdir($HOME."/.vim/swap", "p", 0700)
endif
if !isdirectory($HOME."/.vim/undo")
    call mkdir($HOME."/.vim/undo", "p", 0700)
endif

" Performance
set lazyredraw
set synmaxcol=300
set updatetime=300

" Other settings
set backspace=indent,eol,start
set clipboard=unnamedplus
set mouse=a
set splitbelow splitright
set timeoutlen=500
set ttimeoutlen=0

" =============================================================================
" Theme and Colors
" =============================================================================
set termguicolors
set background=dark
colorscheme gruvbox

" Transparent background
hi Normal guibg=NONE ctermbg=NONE

" =============================================================================
" Key Mappings
" =============================================================================
let mapleader = " "
let maplocalleader = ","

" Quick save and quit
nnoremap <leader>w :w<CR>
nnoremap <leader>q :q<CR>
nnoremap <leader>x :wq<CR>

" Clear search highlighting
nnoremap <leader>h :nohlsearch<CR>

" Better window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprev<CR>
nnoremap <leader>bd :bdelete<CR>

" Tab navigation
nnoremap <leader>tn :tabnext<CR>
nnoremap <leader>tp :tabprev<CR>
nnoremap <leader>tc :tabclose<CR>

" Better indenting
vnoremap < <gv
vnoremap > >gv

" Move lines up/down
nnoremap <A-j> :m .+1<CR>==
nnoremap <A-k> :m .-2<CR>==
vnoremap <A-j> :m '>+1<CR>gv=gv
vnoremap <A-k> :m '<-2<CR>gv=gv

" =============================================================================
" Plugin Configuration
" =============================================================================

" NERDTree
nnoremap <leader>e :NERDTreeToggle<CR>
nnoremap <leader>f :NERDTreeFind<CR>
let NERDTreeShowHidden=1
let NERDTreeIgnore=['\.git$', '\.DS_Store$', '__pycache__', '\.pyc$', 'node_modules']

" FZF
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>rg :Rg<CR>
nnoremap <leader>t :Tags<CR>

" Tagbar
nnoremap <leader>tb :TagbarToggle<CR>

" Airline
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

" ALE Configuration
let g:ale_linters = {
\   'python': ['flake8', 'pylint', 'mypy'],
\   'go': ['golint', 'go vet', 'gofmt'],
\   'rust': ['cargo'],
\   'javascript': ['eslint'],
\   'typescript': ['eslint', 'tslint'],
\}

let g:ale_fixers = {
\   '*': ['remove_trailing_lines', 'trim_whitespace'],
\   'python': ['black', 'isort'],
\   'go': ['gofmt', 'goimports'],
\   'rust': ['rustfmt'],
\   'javascript': ['prettier', 'eslint'],
\   'typescript': ['prettier', 'eslint'],
\}

let g:ale_fix_on_save = 1
let g:ale_sign_error = '❌'
let g:ale_sign_warning = '⚠️'

" =============================================================================
" Language-Specific Configuration
" =============================================================================

" Python
augroup python_settings
    autocmd!
    autocmd FileType python setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
    autocmd FileType python setlocal colorcolumn=88
    autocmd FileType python setlocal textwidth=88
    autocmd FileType python nnoremap <buffer> <leader>r :!python %<CR>
    autocmd FileType python nnoremap <buffer> <leader>R :!python3 %<CR>
augroup END

let g:python_highlight_all = 1

" Go
augroup go_settings
    autocmd!
    autocmd FileType go setlocal tabstop=4 shiftwidth=4 softtabstop=4 noexpandtab
    autocmd FileType go setlocal colorcolumn=100
    autocmd FileType go nnoremap <buffer> <leader>r :GoRun<CR>
    autocmd FileType go nnoremap <buffer> <leader>b :GoBuild<CR>
    autocmd FileType go nnoremap <buffer> <leader>t :GoTest<CR>
augroup END

let g:go_highlight_types = 1
let g:go_highlight_fields = 1
let g:go_highlight_functions = 1
let g:go_highlight_function_calls = 1
let g:go_highlight_methods = 1
let g:go_highlight_operators = 1
let g:go_highlight_extra_types = 1
let g:go_fmt_command = "goimports"
let g:go_auto_type_info = 1

" Rust
augroup rust_settings
    autocmd!
    autocmd FileType rust setlocal tabstop=4 shiftwidth=4 softtabstop=4 expandtab
    autocmd FileType rust setlocal colorcolumn=100
    autocmd FileType rust nnoremap <buffer> <leader>r :RustRun<CR>
    autocmd FileType rust nnoremap <buffer> <leader>b :RustBuild<CR>
    autocmd FileType rust nnoremap <buffer> <leader>t :RustTest<CR>
augroup END

let g:rustfmt_autosave = 1

" JavaScript/TypeScript/Node.js
augroup js_ts_settings
    autocmd!
    autocmd FileType javascript,typescript,json setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
    autocmd FileType javascript,typescript setlocal colorcolumn=100
    autocmd FileType javascript nnoremap <buffer> <leader>r :!node %<CR>
    autocmd FileType typescript nnoremap <buffer> <leader>r :!ts-node %<CR>
augroup END

" JSON, YAML, TOML
augroup config_files
    autocmd!
    autocmd FileType json,yaml,toml setlocal tabstop=2 shiftwidth=2 softtabstop=2 expandtab
augroup END

" =============================================================================
" Custom Functions
" =============================================================================

" Toggle between absolute and relative line numbers
function! NumberToggle()
  if(&relativenumber == 1)
    set norelativenumber
    set number
  else
    set relativenumber
  endif
endfunction

nnoremap <leader>n :call NumberToggle()<CR>

" Remove trailing whitespace
function! TrimWhitespace()
    let l:save = winsaveview()
    keeppatterns %s/\s\+$//e
    call winrestview(l:save)
endfunction

nnoremap <leader>tw :call TrimWhitespace()<CR>

" =============================================================================
" Auto Commands
" =============================================================================

augroup general_settings
    autocmd!
    " Return to last edit position when opening files
    autocmd BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif

    " Disable cursor position restore for Git commit messages
    autocmd FileType gitcommit autocmd! BufReadPost <buffer>"

    " Remove trailing whitespace on save for certain file types
    autocmd BufWritePre *.py,*.js,*.ts,*.go,*.rs call TrimWhitespace()

    " Highlight long lines
    autocmd FileType python,go,rust,javascript,typescript match OverLength /\%101v.\+/
    highlight OverLength ctermbg=red ctermfg=white guibg=#cc6666
augroup END

" =============================================================================
" Status line (if airline is not working)
" =============================================================================
if !exists(':AirlineToggle')
    set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}
endif
