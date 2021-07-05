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
Plug 'christoomey/vim-system-copy'
Plug 'tpope/vim-commentary'
Plug 'airblade/vim-gitgutter'
Plug 'tpope/vim-fugitive'
Plug 'tmhedberg/SimpylFold'
Plug 'psliwka/vim-smoothie'
Plug 'preservim/tagbar'
Plug 'dense-analysis/ale'
Plug 'roxma/nvim-yarp'
Plug 'roxma/vim-hug-neovim-rpc'
Plug 'Shougo/deoplete.nvim'
Plug 'deoplete-plugins/deoplete-jedi'
Plug 'davidhalter/jedi-vim'
Plug 'vim-vdebug/vdebug'
Plug 'embear/vim-localvimrc'
Plug 'wellle/tmux-complete.vim'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'SirVer/ultisnips'
Plug 'honza/vim-snippets'
Plug 'wincent/ferret'
Plug 'yssl/QFEnter'
Plug 'romainl/vim-qf'
Plug 'voldikss/vim-floaterm'
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'
Plug 'iamcco/markdown-preview.nvim', { 'do': 'cd app && yarn install'  }
Plug 'kkoomen/vim-doge', { 'do': { -> doge#install() } }
call plug#end()

filetype plugin indent on

" Load base config
source ~/.dot-cli/.vimrc-base

" IDE version specific config:

" Nerd Tree
let nerdtree_size=42
autocmd vimenter * NERDTree
" Exit Vim if NERDTree is the only window left.
autocmd BufEnter * if tabpagenr('$') == 1 && winnr('$') == 1 && exists('b:NERDTree') && b:NERDTree.isTabTree() |
    \ quit | endif
let NERDTreeShowHidden=1
" Open the existing NERDTree on each new tab. Functionality from jistr/vim-nerdtree-tabs
" replaces native :NERDTreeMirror
autocmd BufWinEnter * silent NERDTreeMirrorOpen
let g:NERDTreeHighlightCursorline = 0
let g:NERDTreeLimitedSyntax = 1
" Expandable/Collapsible symbols. Use +/- for example or comment to use default
"let g:NERDTreeDirArrowExpandable = '+'
"let g:NERDTreeDirArrowCollapsible = '-'
" Nerdtree tabs
let g:nerdtree_tabs_open_on_console_startup=1
let g:NERDTreeWinSize=42
" Nerd tree git plugin
let g:NERDTreeGitStatusUseNerdFonts = 1
" Remove bookmarks and help text from NERDTree
let g:NERDTreeMinimalUI = 1
" Ignore files
let NERDTreeIgnore = ['\.pyc$', '\.pyo$', '\.egg-info$', '__pycache__', '.venv', 'venv']

" Restore splits and fix NERDTree sizing bug.
nnoremap <silent> <C-m>, :NERDTreeFocus<CR> \| :execute ':vertical resize' . nerdtree_size<CR> \| <C-w>= \| :NERDTreeRefreshRoot<CR> \| <C-w>p "
" Toggle Nerdtree
map <silent> <C-n> :NERDTreeToggle<CR> <C-w>=

" FZF
" Default search with ripgrep - all files, except .git
let $FZF_DEFAULT_COMMAND='rg --files --smart-case --hidden --follow --no-ignore --glob "!.git/*"'
let $FZF_DEFAULT_OPTS='--reverse'

" Search files, respect ignore files
command! -bang -nargs=? -complete=dir IFiles
  \ call fzf#vim#files(<q-args>, fzf#vim#with_preview({
  \'source': 'rg --files --smart-case --hidden --follow --glob "!.git/*"',
  \'options': '--reverse'}), <bang>0)

nnoremap ff :IFiles<CR>
nnoremap F :Files<CR>

" Ferret
" Ferret workflow:
" 1. Search with :Ack - all project files, :FerretAckWord - word under cursor or :Back - current buffer
" 2. Navigate quickfix list and delete unwanted occurences
" 3. Replace with :Acks /foo/bar/
nmap fa :Ack<space>
nmap fb :Back<space>
nmap ca :Ack<space><C-r><C-w>
nmap cb :Back<space><C-r><C-w>
nmap fr <Plug>(FerretAcks)

" augroup DragQuickfixWindowDown
"     autocmd!
"     autocmd FileType qf wincmd L
" augroup end
"
" Loclist keymap
" autocmd FileType qf map <buffer> <Enter> :execute line(".") . 'll'<CR>

" QFEnter
let g:qfenter_exclude_filetypes = ['nerdtree', 'tagbar']
let g:qfenter_keymap = {}
let g:qfenter_keymap.open = ['<CR>', '<2-LeftMouse>']
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

" vim-qf
nmap <C-q> <Plug>(qf_qf_toggle)
nmap <C-l> <Plug>(qf_loc_toggle)
nmap <buffer> <Left>  <Plug>(qf_older)
nmap <buffer> <Right> <Plug>(qf_newer)

" let g:qf_window_bottom = 0
" let g:qf_loclist_window_bottom = 0
let g:qf_nowrap = 0
let g:qf_auto_resize = 0
let g:qf_auto_open_quickfix = 0
let g:qf_auto_open_loclist = 0

" let g:qf_save_win_view = 0

" vim-devicons settings
" adding to vim-airline's tabline
let g:webdevicons_enable_airline_tabline = 1
" disable vim-devicons in vim-airline's statusline
let g:webdevicons_enable_airline_statusline = 0
" ctrlp glyphs
let g:webdevicons_enable_ctrlp = 1
" Force extra padding in NERDTree so that the filetype icons line up vertically
let g:WebDevIconsNerdTreeGitPluginForceVAlign = 1
" enable open and close folder/directory glyph flags (disabled by default with 0)
let g:DevIconsEnableFoldersOpenClose = 1

" vim-gitgutter
let g:gitgutter_map_keys = 0
let g:gitgutter_sign_allow_clobber = 1
let g:gitgutter_preview_win_floating = 1
nmap ghp <Plug>(GitGutterPreviewHunk)

" Tagbar
nmap <F8> :TagbarToggle<CR>

" vim-doge (doc gen) keymap
" navigate TODO <Tab> <S-Tab>
let g:doge_mapping = "<leader>s"
let g:doge_doc_standard_python = 'sphinx'

" ultisnips settings
" Snippets workflow:
" 1. Start type keyword
" 2. Select snippet in expanded list
" 3. Expand snippet with UltiSnipsExpandTrigger (default <C-s>)
let g:UltiSnipsExpandTrigger="<C-s>"
let g:UltiSnipsListSnippets="<C-l>"
let g:UltiSnipsJumpForwardTrigger="<Down>"
let g:UltiSnipsJumpBackwardTrigger="<Up>"
" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

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
\   'python': ['black', 'isort'],
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

" Python black fixing options.
" Default black line length is 88
" You can bind flake linter line length to 88 with:
" let g:ale_python_flake8_options = '--max-line-length=88'
" or setup black line length to default 79:
let g:ale_python_black_options = '--line-length 79'

" Isort options.
let g:ale_python_isort_options = '--profile black'

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
let g:deoplete#disable_auto_complete = 1
inoremap <expr> <C-n>  deoplete#manual_complete()
call deoplete#custom#option('smart_case', v:true)
let g:deoplete#sources#jedi#ignore_errors = 1

" jedi-vim settings
let g:jedi#use_tabs_not_buffers = 1
" let g:jedi#use_splits_not_buffers = "right"
let g:jedi#completions_enabled = 0
let g:jedi#show_call_signatures = "0"
let g:jedi#goto_command = "<leader>jj"
let g:jedi#goto_assignments_command = "<leader>j"
let g:jedi#goto_stubs_command = ""
let g:jedi#goto_definitions_command = ""
let g:jedi#documentation_command = "K"
let g:jedi#usages_command = "<leader>n"
"let g:jedi#completions_command = "<C-Space>"
let g:jedi#rename_command = "<leader>r"

" Preview/Toggle markdown in browser
nmap <silent> <leader>m <Plug>MarkdownPreviewToggle

" Vdebug settings
" Debugging workflow:
" 1. Set breakpoints or use Run to cursor (<F9>)
" 2. Run debugger - <F5>
" 3. Run target script:
"   For python use: pydbgp myscript.py
" 4. Navigate over breakpoints <F2> <F3> <F4> or use <F9>
let g:vdebug_keymap = {
\    "run" : "<F5>",
\    "run_to_cursor" : "<F9>",
\    "step_over" : "<F2>",
\    "step_into" : "<F3>",
\    "step_out" : "<F4>",
\    "close" : "q",
\    "detach" : "x",
\    "set_breakpoint" : "<F10>",
\    "get_context" : "<F11>",
\    "eval_under_cursor" : "<leader>c",
\    "eval_visual" : "<leader>v"
\}

" Init options
if !exists('g:vdebug_options')
    let g:vdebug_options = {}
endif

" Stops execution at the first line.
let g:vdebug_options['break_on_open'] = 1
let g:vdebug_options['max_children'] = 128
" Use the window layout (expanded|compact)
let g:vdebug_options['watch_window_style'] = 'expanded'
" Change this if needed
let g:vdebug_options['ide_key'] = 'DEBUG'

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
map <silent> <leader>g :lcd %:p:h<CR>:vsplit \| term lazygit<CR>
" vertical split maximized
map <silent> <leader>gf :lcd %:p:h<CR>:vsplit \| <Enter><CR>:term lazygit<CR>

" Open Lazydocker in:
" vertical split
map <silent> <leader>c :vsplit \| term lazydocker<CR>
" vertical split maximized
map <silent> <leader>cf :vsplit \| <Enter><CR>:term lazydocker<CR>

" Load .lvimrc without confirmation
let g:localvimrc_ask = 0

