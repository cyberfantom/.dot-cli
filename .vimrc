set encoding=UTF-8
set mouse=a
set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
" Vundle Plugins
Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree.git'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'ryanoasis/vim-devicons'
Plugin 'Buffergator'
Plugin 'tpope/vim-surround'
Plugin 'sheerun/vim-polyglot'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'morhetz/gruvbox'
Plugin 'Yggdroot/indentLine'

call vundle#end()
filetype plugin indent on

" Powerline
python3 from powerline.vim import setup as powerline_setup
python3 powerline_setup()
python3 del powerline_setup

let g:powerline_pycmd="py3"
let g:powerline_pyeval="py3eval"
set laststatus=2
set noshowmode

" Misc
set enc=utf-8
syntax on
set cursorline
set number
set showmatch
set noruler
set title
set shortmess=at
set noshowcmd
set cmdheight=1
set nobackup
set nowritebackup
set noswapfile
silent! set notermguicolors
set background=dark
set mouse-=a

" Splits
set splitbelow
set splitright

" Tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent

" Color scheme
" comment set t_Co and t_ut on modern terminals
set t_Co=256
set t_ut=
silent! colorscheme gruvbox

" Indent Line
let g:indentLine_char = '│' " ASCII 179
map <C-i> :IndentLinesToggle<CR>

" Hidden symbols
set showbreak=↪\
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
map <C-h> :set list!<CR>

" Nerd Tree
autocmd vimenter * NERDTree
let NERDTreeShowHidden=1
let g:NERDTreeMouseMode=3
map <C-n> :NERDTreeToggle<CR>
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeLimitedSyntax = 1
" Nerd tree tabs
let g:nerdtree_tabs_open_on_console_startup=1

" Terminal
map <F3> :vert term<CR>
map <F4> :below term<CR>
