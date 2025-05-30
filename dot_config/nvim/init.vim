" Basic Settings
set nocompatible              " Be iMproved, required
syntax enable                 " Enable syntax highlighting
set number                   " Show line numbers
set relativenumber           " Show relative line numbers
set cursorline              " Highlight current line
set mouse=a                 " Enable mouse support
set encoding=utf-8          " Set encoding
set fileencoding=utf-8      " Set file encoding

" Indentation
set autoindent              " Auto-indent new lines
set expandtab               " Use spaces instead of tabs
set shiftwidth=4            " Number of auto-indent spaces
set smartindent             " Enable smart indent
set softtabstop=4          " Number of spaces per Tab
set tabstop=4              " Number of visual spaces per Tab

" Search
set hlsearch                " Highlight search results
set ignorecase              " Case insensitive search
set incsearch               " Incremental search
set smartcase               " Smart case search

" Visual
set termguicolors          " Enable true colors support
set background=dark        " Set background color
set showmatch              " Highlight matching brackets
set signcolumn=yes         " Always show signcolumn

" Performance
set updatetime=300         " Faster completion
set timeout timeoutlen=500 " Faster key sequence completion

" File Management
set noswapfile             " Disable swap file
set nobackup               " Disable backup file
set undofile               " Enable persistent undo
set undodir=~/.vim/undodir " Set undo directory

" Status Line
set laststatus=2           " Always show status line
set noshowmode             " Don't show mode in command line

" Key Mappings
let mapleader = " "        " Set leader key to space

" Easy window navigation
nnoremap <C-h> <C-w>h
nnoremap <C-j> <C-w>j
nnoremap <C-k> <C-w>k
nnoremap <C-l> <C-w>l

" Quick save
nnoremap <leader>w :w<CR>

" Clear search highlighting
nnoremap <leader>h :noh<CR>

" Buffer navigation
nnoremap <leader>bn :bnext<CR>
nnoremap <leader>bp :bprevious<CR>
