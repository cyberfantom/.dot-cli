set nocompatible
filetype off
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()

" Plugins
Plugin 'gmarik/vundle'
Plugin 'scrooloose/nerdtree.git'
Plugin 'jistr/vim-nerdtree-tabs'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'Buffergator'
Plugin 'tomasiser/vim-code-dark'
Plugin 'vim-airline/vim-airline'
Plugin 'tpope/vim-surround'
Plugin 'sheerun/vim-polyglot'

call vundle#end()
filetype plugin indent on

" Misc
set enc=utf-8
syntax on
set cursorline
set number
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

" color scheme
" comment set t_Co and t_ut on modern terminals
set t_Co=256
set t_ut=
silent! colorscheme codedark
let g:airline_theme = 'codedark'

" Nerd Tree
autocmd vimenter * NERDTree
let NERDTreeShowHidden=1
map <C-n> :NERDTreeToggle<CR>
" Nerd tree tabs
let g:nerdtree_tabs_open_on_console_startup=1

" Terminal
map <F3> :vert term<CR>
map <F4> :below term<CR>
