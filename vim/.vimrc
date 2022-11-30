" Light version specific plugins
call plug#begin()
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'szw/vim-maximizer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'christoomey/vim-system-copy'
Plug 'tpope/vim-commentary'
Plug 'tmhedberg/SimpylFold'
Plug 'psliwka/vim-smoothie'
Plug 'mbbill/undotree'
call plug#end()

" Load base config
source ~/.dot-cli/vim/.vimrc-base

" Light version specific config:

" Open native terminal (same path as current opened file)
" horizontal
map <silent> <leader>th :lcd %:p:h<CR>:term ++close<CR>
" vertical
map <silent> <leader>tv :lcd %:p:h<CR>:vert term ++close<CR>

" Load user config
call SourceIfExists("~/.dotclivim.vim")
