set nocompatible
set lazyredraw
set ttyfast
filetype off
"set writedelay=1

" IDE version specific plugins
call plug#begin('~/.config/nvim/plugged')
Plug 'preservim/nerdtree'
Plug 'jistr/vim-nerdtree-tabs'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'tmux-plugins/vim-tmux-focus-events'
Plug 'morhetz/gruvbox'
Plug 'Yggdroot/indentLine'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'christoomey/vim-system-copy'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
"Plug 'junegunn/gv.vim'
Plug 'tmhedberg/SimpylFold'
Plug 'psliwka/vim-smoothie'
Plug 'preservim/tagbar'
Plug 'dense-analysis/ale'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Shougo/deoplete.nvim'
Plug 'wellle/tmux-complete.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'voldikss/vim-floaterm'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
call plug#end()

filetype plugin indent on

" Load base config
source ~/.dot-cli/.vimrc-base

" IDE version specific config:

" Nerd Tree
autocmd vimenter * NERDTree
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
let NERDTreeShowHidden=1
" Open the existing NERDTree on each new tab.
autocmd BufWinEnter * silent NERDTreeMirror
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeLimitedSyntax = 1
" Expandable/Collapsible symbols. Use +/- for example or comment to use default
"let g:NERDTreeDirArrowExpandable = '+'
"let g:NERDTreeDirArrowCollapsible = '-'
" Nerdtree tabs
let g:nerdtree_tabs_open_on_console_startup=1
let g:NERDTreeWinSize=nerdtree_size
" Nerd tree git plugin
let g:NERDTreeGitStatusUseNerdFonts = 1
" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1

" Restore splits and fix NERDTree sizing bug.
nnoremap <silent> <C-m>, :NERDTreeFocus<CR> \| :execute ':vertical resize' . nerdtree_size<CR> \| <C-w>= \| :NERDTreeRefreshRoot<CR> \| <C-w>p "
" Toggle Nerdtree
map <silent> <C-n> :NERDTreeToggle<CR> <C-w>=

" vim-devicons settings
" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1
" adding to vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 1
" ctrlp glyphs
let g:webdevicons_enable_ctrlp = 1
" Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
" enable open and close folder/directory glyph flags (disabled by default with 0)
let g:DevIconsEnableFoldersOpenClose = 1

" Tagbar
nmap <F8> :TagbarToggle<CR>

" ALE
" Linting
let g:ale_linters = {
\   'vim': ['vint'],
\   'python': ['flake8'],
\   'yaml': ['yamllint'],
\   'sh': ['shellcheck'],
\   'markdown': ['proselint'],
\   'text': ['proselint'],
\   'html': ['tidy'],
\   'json': ['jq'],
\}
" YAML Linting options
let g:ale_yaml_yamllint_options='-d "{extends: default, rules: {document-start: disable}}"'

" Fixing
let g:ale_fixers = {
\   '*': ['trim_whitespace'],
\   'python': ['yapf'],
\   'yaml': ['prettier'],
\   'sh': ['shfmt'],
\   'markdown': ['prettier'],
\   'html': ['tidy', 'prettier'],
\   'json': ['jq', 'prettier'],
\   'javascript': ['prettier'],
\   'css': ['prettier'],
\}
" Javascript fixing options
let g:ale_javascript_prettier_options = '--single-quote --trailing-comma all'

" Only run linters named in ale_linters settings.
let g:ale_linters_explicit = 1
" Set this variable to 1 to fix files when you save them.
let g:ale_fix_on_save = 0
" Disable warnings about trailing whitespace
let b:ale_warn_about_trailing_whitespace = 0

let g:ale_set_loclist = 1
let g:ale_keep_list_window_open = 0
let g:ale_list_window_size = 15
let g:ale_list_vertical = 1

" ALE keymap
nmap <silent> <leader>f :ALEFix<CR>

" Use deoplete.
let g:deoplete#enable_at_startup = 1

" Preview/Toggle markdown in browser
nmap <silent> <leader>m <Plug>MarkdownPreviewToggle

" Open commit browser
map <silent> <leader>g :GV<CR>
" Open commit browser with commits that affected the current file
map <silent> <leader>gf :GV!<CR>

" Terminal
if has('nvim')
    augroup neovim_terminal
    autocmd!

    " Enter Terminal-mode (insert) automatically
    autocmd TermOpen * startinsert

    " Disables number lines on terminal buffers
    autocmd TermOpen * :set nonumber norelativenumber

    " Close terminal without [Process exited ..]
    autocmd TermClose * silent :q
  augroup END
endif

" Floaterm
let g:floaterm_autoclose=2
nnoremap <silent> <leader>t :FloatermToggle<CR>
tnoremap <silent> <leader>t <C-\><C-n>:FloatermToggle<CR>

" Open native terminal (same path as current opened file)
" horizontal
map <silent> <leader>` :lcd %:p:h<CR>:split \| term<CR>
" vertical
map <silent> <leader>`1 :lcd %:p:h<CR>:vsplit \| term<CR>

" Open Lazygit in:
" vertical split
map <silent> <leader>g :vsplit \| term lazygit<CR>
" vertical split maximized
map <silent> <leader>gf :vsplit \| <Enter><CR>:term lazygit<CR>
