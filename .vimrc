set nocompatible
filetype off

" Light version specific plugins
set rtp+=~/.vim/bundle/vundle/
call vundle#begin()
" Vundle Plugins
Plugin 'gmarik/vundle'
Plugin 'tpope/vim-surround'
Plugin 'sheerun/vim-polyglot'
Plugin 'tmux-plugins/vim-tmux-focus-events'
Plugin 'morhetz/gruvbox'
Plugin 'Yggdroot/indentLine'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'christoomey/vim-system-copy'
Plugin 'tpope/vim-commentary'
Plugin 'tmhedberg/SimpylFold'
Plugin 'psliwka/vim-smoothie'
call vundle#end()
filetype plugin indent on

" Load base config
source ~/.dot-cli/.vimrc-base

" Light version specific config:

" Restore splits
nnoremap <silent> <C-m>, <C-w>=

" Open native terminal (same path as current opened file)
" horizontal
map <silent> <leader>` :lcd %:p:h<CR>:term ++close<CR>
" vertical
map <silent> <leader>`1 :lcd %:p:h<CR>:vert term ++close<CR>
