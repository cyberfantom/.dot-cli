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
Plugin 'tpope/vim-surround'
Plugin 'sheerun/vim-polyglot'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'morhetz/gruvbox'
Plugin 'Yggdroot/indentLine'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'christoomey/vim-system-copy'
Plugin 'tpope/vim-commentary'
Plugin 'airblade/vim-gitgutter'

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
set fileformats="unix,dos,mac"
set formatoptions+=1
set autoread
set updatetime=1000
silent! set notermguicolors
set background=dark
set mouse-=a
let &colorcolumn="80,".join(range(120,999),",")
set modifiable
"" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
"" Remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e
"" Optional custom variables
let nerdtree_size=42

" Splits
set splitbelow
set splitright

" Adjusing split sizes
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>
" Maximize / restore splits
nnoremap <silent> <C-m> <C-w>\|<C-w>_
"" Restore splits and fix NERDTree sizing bug.
nnoremap <silent> <C-m>, :NERDTreeFocus<CR> \| :execute ':vertical resize' . nerdtree_size<CR> \| <C-w>= \| :NERDTreeRefreshRoot<CR> \| <C-w>p "

" Tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent

" Removes pipes | that act as seperators on splits
set fillchars+=vert:▌ " ASCII 221 or ║ - ASCII 186

" Color scheme
" comment set t_Co and t_ut on modern terminals
set t_Co=256
set t_ut=
silent! colorscheme gruvbox

" Indent Line
let g:indentLine_char = '│' " ASCII 179
map <silent> <C-i> :IndentLinesToggle<CR>
let g:indentLine_setConceal = 2
" default ''.
" n for Normal mode
" v for Visual mode
" i for Insert mode
" c for Command line editing, for 'incsearch'
let g:indentLine_concealcursor = ""

" CtrlP
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" Hidden symbols
function! ConcealLevelToggle()
    if &conceallevel
        setlocal conceallevel=0
    else
        setlocal conceallevel=2
    endif
endfunction
set showbreak=↪\
set listchars=tab:→\ ,eol:↲,nbsp:␣,trail:•,extends:⟩,precedes:⟨
map <silent> <C-h> :set list!<CR> \| :call ConcealLevelToggle()<CR>

" Dev icons
let g:webdevicons_enable = 1
let g:webdevicons_enable_nerdtree = 1
let g:webdevicons_enable_ctrlp = 1
let g:WebDevIconsUnicodeGlyphDoubleWidth = 1

" Nerd Tree
autocmd vimenter * NERDTree
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif
let NERDTreeShowHidden=1
map <silent> <C-n> :NERDTreeToggle<CR> <C-w>=
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeLimitedSyntax = 1
let g:NERDTreeDirArrowExpandable = '+'
let g:NERDTreeDirArrowCollapsible = '-'
" Nerd tree tabs
let g:nerdtree_tabs_open_on_console_startup=1
let g:NERDTreeWinSize=nerdtree_size
" Nerd tree git plugin
let g:NERDTreeGitStatusUseNerdFonts = 1

" Terminal
map <silent> <F2> :vert term ++close<CR>
map <silent> <F3> :below term ++close<CR>
" Preview markdown in vertical split
nnoremap <silent> <leader>m :vert term bash -c "mdv -L -t 960.847 % \| sed 's/&lt;/</g' \| sed 's/&gt;/>/g'" \| Info: markdown preview #<CR>
" Fast window close
map <leader>q :q<CR>
" Fast window close without saving
map <leader>q1 :q!<CR>
" Fast close all windows without saving
map <leader>qa :qa!<CR>
" Fast save
map <leader>w :w<CR>
" Launch Tig git manager
map <silent> <leader>g :vert term ++close bash -c "tig"<CR>