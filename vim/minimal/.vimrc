" Minimal Vim Configuration for Bash Environment
" Lightweight setup without heavy language-specific plugins

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

" Essential plugins only
Plug 'tpope/vim-sensible'           " Sensible defaults
Plug 'tpope/vim-surround'           " Surrounding text objects
Plug 'tpope/vim-commentary'         " Easy commenting
Plug 'tpope/vim-fugitive'           " Git integration
Plug 'tpope/vim-repeat'             " Repeat plugin commands

" File management
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'preservim/nerdtree'

" UI enhancements
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'morhetz/gruvbox'

" Basic syntax and formatting
Plug 'sheerun/vim-polyglot'
Plug 'editorconfig/editorconfig-vim'

" Simple productivity plugins
Plug 'jiangmiao/auto-pairs'
Plug 'airblade/vim-gitgutter'

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
set encoding=utf-8
set fileencoding=utf-8

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
let NERDTreeIgnore=['\.git$', '\.DS_Store$', '__pycache__', '\.pyc$']

" FZF
nnoremap <leader>p :Files<CR>
nnoremap <leader>b :Buffers<CR>
nnoremap <leader>rg :Rg<CR>

" Airline
let g:airline_theme='gruvbox'
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tabline#formatter = 'unique_tail'

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

    " Disabled corsor position restore for Git Messages
    autocmd FileType gitcommit autocmd! BufReadPost <buffer>

    " Remove trailing whitespace on save for common file types
    autocmd BufWritePre *.py,*.sh,*.txt,*.md call TrimWhitespace()
augroup END

" =============================================================================
" Status line (if airline is not working)
" =============================================================================
if !exists(':AirlineToggle')
    set statusline=%F%m%r%h%w\ [FORMAT=%{&ff}]\ [TYPE=%Y]\ [POS=%l,%v][%p%%]\ [BUFFER=%n]\ %{strftime('%c')}
endif
