" Base settings
set laststatus=2
set noshowmode
set encoding=utf-8
set syntax=on
set cursorline
set number
set showmatch
set noruler
set title
" set shortmess=aoOtI
set shortmess+=
set noshowcmd
set cmdheight=1
set nobackup
set nowritebackup
set noswapfile
set fileformats="unix,dos,mac"
set formatoptions+=1
set autoread
set updatetime=1000
silent! set termguicolors " or try notermguicolors
set background=dark "" light | dark
set mouse-=a
"" Set document rulers and disable for specific filetypes
let &colorcolumn="88,".join(range(128,999),",")
au FileType qf setlocal colorcolumn=
au FileType Trouble setlocal colorcolumn=
set modifiable
"" No annoying sound on errors
set noerrorbells
set novisualbell
set t_vb=
set tm=500
"" Remove trailing whitespaces
autocmd BufWritePre * :%s/\s\+$//e

" Splits
set splitbelow
set splitright

" Enable folding
" Use za keys to fold/unfold block
set foldmethod=indent
set foldlevel=99
" SimpylFold settings
let g:SimpylFold_docstring_preview=1

" Adjusing split sizes
noremap <silent> <C-Left> :vertical resize +3<CR>
noremap <silent> <C-Right> :vertical resize -3<CR>
noremap <silent> <C-Up> :resize +3<CR>
noremap <silent> <C-Down> :resize -3<CR>

" Toggle diff splits in window
function! DiffToggle()
    if &diff
        windo diffoff
    else
        windo diffthis
    endif
endfunction
nnoremap <silent> <leader>/ :call DiffToggle()<CR>

" Add new line(s) in normal mode
nnoremap <leader><Enter> o<Esc>
" nnoremap <leader><Enter> O<Esc>j " add lines upper

" delete without yanking
nnoremap <leader>d "_d
vnoremap <leader>d "_d
nnoremap <leader>dd "_dd
vnoremap <leader>dd "_dd

" replace currently selected text with default register without yanking it
vnoremap <leader>p "_dP
nnoremap <leader>p "_dP

" Insert space in normal mode (after cursor)
nnoremap <Space> a<Space><Right><Esc>

" Make double-<Esc> clear search highlights
nnoremap <silent> <Esc><Esc> <Esc>:nohlsearch<CR><Esc>

" Tabs
set tabstop=4
set shiftwidth=4
set smarttab
set expandtab
set smartindent

" Removes pipes | that act as seperators on splits
set fillchars+=vert:▌ " ASCII 221 or ║ - ASCII 186

" Set t_Co and t_ut on modern terminals
set t_Co=256
set t_ut=

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

" Exit from terminal insert mode with leader-ESC
tnoremap <leader><Esc> <C-\><C-n>

" Fast buffer close
map <leader>q :q<CR>
" Fast buffer close without saving
map <leader>q1 :q!<CR>
" Fast close all buffers without saving
map <leader>qa :qa!<CR>
" Fast close all buffers in current window
map <leader>qw :windo q<CR>
" Fast save
map <leader>w :w<CR>

" Toggle quickfix list
" For the location list replace copen/cclose with lopen/lclose, and v:val.quickfix with v:val.loclist
function! ToggleQuickFix()
    if empty(filter(getwininfo(), 'v:val.quickfix'))
        copen
    else
        cclose
    endif
endfunction
nnoremap <silent> <leader>x :call ToggleQuickFix()<CR>

" Function to source only if file exists {
function! SourceIfExists(file)
  if filereadable(expand(a:file))
    exe 'source' a:file
  endif
endfunction
" }

" Toggle Maximized window
let g:maximizer_set_default_mapping = 1
let g:maximizer_set_mapping_with_bang = 1
let g:maximizer_default_mapping_key = '<F3>'

