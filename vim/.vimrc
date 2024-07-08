" Light version specific plugins
call plug#begin()
Plug 'tpope/vim-surround'
Plug 'sheerun/vim-polyglot'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'Yggdroot/indentLine'
Plug 'szw/vim-maximizer'
Plug 'ctrlpvim/ctrlp.vim'
Plug 'tpope/vim-commentary'
Plug 'tmhedberg/SimpylFold'
Plug 'psliwka/vim-smoothie'
call plug#end()

" Load base config
source ~/.dot-cli/vim/viml/base.vim

" Airline
let g:airline_theme='gruvbox'
" let g:airline_theme='gruvbox_material'
let g:airline#extensions#tabline#enabled = 1
let g:airline#extensions#tagbar#enabled = 0
let g:airline#extensions#whitespace#enabled = 0
let g:airline_powerline_fonts = 1
let g:airline#extensions#tabline#show_close_button = 0
let g:airline#extensions#tabline#tab_nr_type = 1
let g:airline#extensions#tabline#show_tab_nr = 1
let g:airline#extensions#tabline#tabs_label = ''
let g:airline#extensions#tabline#buffers_label = ''
let g:airline#extensions#tabline#formatter = 'unique_tail_improved'
"let g:airline#extensions#tabline#fnamemod = ':t'       " disable file paths in the tab - affects to formatter settings
"let g:airline_section_c = '%t'
let g:airline#extensions#tabline#show_tab_count = 0    " dont show tab numbers on the right
let g:airline#extensions#tabline#show_buffers = 0      " dont show buffers in the tabline
let g:airline#extensions#tabline#tab_min_count = 2     " minimum of 2 tabs needed to display the tabline
let g:airline#extensions#tabline#show_splits = 0       " disables the buffer name that displays on the right of the tabline
let g:airline#extensions#tabline#show_tab_type = 0     " disables the weird ornage arrow on the tabline
let g:airline#extensions#term#enabled = 0              " disable term integration
let g:airline#extensions#hunks#enabled = 0             " Don't show git changes to current file in airline
let g:airline_skip_empty_sections = 1 " Do not draw separators for empty sections
let g:airline_highlighting_cache = 0
" Customize vim airline per filetype
" 'nerdtree'  - Hide nerdtree status line
" 'list'      - Only show file type plus current line number out of total
let g:airline_filetype_overrides = {
  \ 'nerdtree': [ get(g:, 'NERDTreeStatusline', ''), '' ],
  \ 'list': [ '%y', '%l/%L'],
  \ }

" Color scheme
let g:gruvbox_italic=1
let g:gruvbox_contrast_dark="medium"
let g:gruvbox_contrast_light="medium"
silent! colorscheme gruvbox

" CtrlP
let g:ctrlp_custom_ignore = {
  \ 'dir':  '\v[\/]\.(git|hg|svn)$',
  \ 'file': '\v\.(exe|so|dll)$',
  \ }

" Open native terminal (same path as current opened file)
" horizontal
map <silent> <leader>th :lcd %:p:h<CR>:term ++close<CR>
" vertical
map <silent> <leader>tv :lcd %:p:h<CR>:vert term ++close<CR>

" Indent Line
let g:indentLine_char = '│' " ASCII 179
let g:indentLine_setConceal = 2
" default ''.
" n for Normal mode
" v for Visual mode
" i for Insert mode
" c for Command line editing, for 'incsearch'
let g:indentLine_concealcursor = ""
" disable indent lines in nerdtree
let g:indentLine_fileTypeExclude = ["nerdtree"]

" Load user config
call SourceIfExists("~/.dotclivim.vim")
