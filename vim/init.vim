set nocompatible
set lazyredraw
set ttyfast
filetype off
"set writedelay=1

" Load plugins
source ~/.dot-cli/vim/init-plugins.vim

filetype plugin indent on

" Load base config
source ~/.dot-cli/vim/.vimrc-base

" IDE version specific config:

" Telescope
lua << EOF
require('telescope').setup{
  defaults = {
    vimgrep_arguments = {
      'rg',
      '--color=never',
      '--no-heading',
      '--with-filename',
      '--line-number',
      '--column',
      '--smart-case'
    },
  }
}
EOF
nnoremap ff <cmd>lua require('telescope.builtin').find_files()<cr>
nnoremap fg <cmd>lua require('telescope.builtin').live_grep()<cr>
nnoremap fb <cmd>lua require('telescope.builtin').buffers()<cr>
nnoremap fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap fe <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap fd <cmd>lua require('telescope.builtin').lsp_document_diagnostics()<cr>
nnoremap fl <cmd>lua require('telescope.builtin').builtin()<cr>

" nvim-tree settings
let g:nvim_tree_width = 42
let g:nvim_tree_ignore = [ '.git', 'node_modules', '\.pyc$', '\.pyo$', '\.egg-info$', '__pycache__', '.venv', 'venv']
let g:nvim_tree_auto_open = 1
let g:nvim_tree_auto_close = 1
let g:nvim_tree_follow = 1
let g:nvim_tree_indent_markers = 1
let g:nvim_tree_highlight_opened_files = 1
let g:nvim_tree_tab_open = 1
let g:nvim_tree_hijack_cursor = 0
let g:nvim_tree_add_trailing = 1
let g:nvim_tree_git_hl = 1
let g:nvim_tree_show_icons = {
    \ 'git': 0,
    \ 'folders': 1,
    \ 'files': 1,
    \ 'folder_arrows': 1,
    \ }
let g:nvim_tree_icons = {
    \ 'default': '',
    \ 'symlink': '',
    \ 'git': {
    \   'unstaged': "✗",
    \   'staged': "✓",
    \   'unmerged': "",
    \   'renamed': "➜",
    \   'untracked': "•",
    \   'deleted': "",
    \   'ignored': "◌"
    \   },
    \ 'folder': {
    \   'arrow_open': "",
    \   'arrow_closed': "",
    \   'default': "",
    \   'open': "",
    \   'empty': "",
    \   'empty_open': "",
    \   'symlink': "",
    \   'symlink_open': "",
    \   },
    \   'lsp': {
    \     'hint': "",
    \     'info': "",
    \     'warning': "",
    \     'error': "",
    \   }
    \ }
highlight NvimTreeIndentMarker guifg=#555756
nnoremap <C-n> :NvimTreeToggle<CR>

" LSP config
lua << EOF
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  buf_set_keymap('n', 'gj', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>tab split | lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', 'gu', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
end

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local capabilities = vim.lsp.protocol.make_client_capabilities()
capabilities.textDocument.completion.completionItem.snippetSupport = true

local servers = { 'pyright', 'rust_analyzer', 'gopls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    flags = {
      debounce_text_changes = 150,
    }
  }
end

-- disable inline diagnostics messages
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
    vim.lsp.diagnostic.on_publish_diagnostics, {
        virtual_text = false,
        signs = true,
        update_in_insert = true
    }
)
EOF

" Lspsaga config
lua << EOF
local saga = require 'lspsaga'
saga.init_lsp_saga {
    max_preview_lines = 15,
    finder_action_keys = {
        open = 'o', vsplit = 's',split = 'i',quit = 'q',scroll_down = '<C-f>', scroll_up = '<C-u>'
    },
    code_action_keys = {
        quit = 'q',exec = '<CR>'
    },
    rename_action_keys = {
        quit = 'q',exec = '<CR>'
    },
}

EOF
nnoremap <silent><leader>ca <cmd>lua require('lspsaga.codeaction').code_action()<CR>
vnoremap <silent><leader>ca :<C-U>lua require('lspsaga.codeaction').range_code_action()<CR>
nnoremap <silent> K <cmd>lua require('lspsaga.hover').render_hover_doc()<CR>
nnoremap <silent> <C-f> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(1)<CR>
nnoremap <silent> <C-u> <cmd>lua require('lspsaga.action').smart_scroll_with_saga(-1)<CR>
nnoremap <silent> gs <cmd>lua require('lspsaga.signaturehelp').signature_help()<CR>
nnoremap <silent>gr <cmd>lua require('lspsaga.rename').rename()<CR>
nnoremap <silent> gp <cmd>lua require'lspsaga.provider'.preview_definition()<CR>
nnoremap <silent>ge <cmd>lua require'lspsaga.diagnostic'.show_line_diagnostics()<CR>

" nvim-compe settings
lua << EOF
vim.o.completeopt = "menuone,noselect"
require'compe'.setup {
  enabled = true;
  autocomplete = true;
  debug = false;
  min_length = 1;
  preselect = 'enable';
  throttle_time = 80;
  source_timeout = 200;
  resolve_timeout = 800;
  incomplete_delay = 400;
  max_abbr_width = 100;
  max_kind_width = 100;
  max_menu_width = 100;
  documentation = {
    border = { '', '' ,'', ' ', '', '', '', ' ' }, -- the border option is the same as `|help nvim_open_win|`
    winhighlight = "NormalFloat:CompeDocumentation,FloatBorder:CompeDocumentationBorder",
    max_width = 120,
    min_width = 60,
    max_height = math.floor(vim.o.lines * 0.3),
    min_height = 1,
  };

  source = {
    path = true;
    buffer = true;
    calc = true;
    nvim_lsp = true;
    nvim_lua = true;
    vsnip = true;
    ultisnips = true;
    luasnip = true;
    tmux = true;
  };
}
EOF
inoremap <silent><expr> <C-n>     compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-c>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-u>     compe#scroll({ 'delta': -4 })

" TreeSitter config
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "maintained",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = false,
  },
  refactor = {
    highlight_definitions = { enable = true },
    smart_rename = {
      enable = true,
      keymaps = {
        smart_rename = "grr",
      },
    },
  },

}
EOF
" Fix some Python operators highlighting
autocmd FileType python highlight link TSKeywordOperator Keyword
" or optional use: highlight link pythonTSKeywordOperator Keyword

" Ferret
" Ferret workflow:
" 1. Search with :Ack - all project files, :FerretAckWord - word under cursor or :Back - current buffer
" 2. Navigate quickfix list and delete unwanted occurences
" 3. Replace with :Acks /foo/bar/
nmap fa :Ack<space>
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
let g:qfenter_exclude_filetypes = ['nerdtree', 'nvimtree', 'tagbar']
let g:qfenter_keymap = {}
let g:qfenter_keymap.open = ['<CR>', '<2-LeftMouse>']
let g:qfenter_keymap.vopen = ['<C-v>']
let g:qfenter_keymap.hopen = ['<C-x>']
let g:qfenter_keymap.topen = ['<C-t>']

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
let g:doge_mapping = "<Leader>s"
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
let g:ultisnips_python_style = "sphinx"

" ALE
" Linting
" as long as we use LSP - we can skip python linter, or use directly: 'python': ['pyright'],
let g:ale_linters = {
\   'vim': ['vint'],
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

" Preview/Toggle markdown in browser
nmap <silent> <leader>m <Plug>MarkdownPreviewToggle

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

