set nocompatible
set lazyredraw
set ttyfast
filetype off
"set writedelay=1

" Plugins preload settings
" vim-polyglot settings
let g:polyglot_disabled = ['autoindent']
autocmd BufEnter * set indentexpr=

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
nnoremap fa <cmd>lua require('telescope.builtin').live_grep()<cr>
" Current buffer find without fuzzy algorytm, works same as live_grep
" nnoremap fb <cmd>lua require'telescope.builtin'.live_grep{ search_dirs={"%:p"} }<cr>
nnoremap fb <cmd>lua require("telescope.builtin").current_buffer_fuzzy_find({prompt_title = "Current Buffer Find", sorter = require('telescope.sorters').get_substr_matcher()})<cr>
" nnoremap fh <cmd>lua require('telescope.builtin').help_tags()<cr>
nnoremap ft <cmd>lua require('telescope.builtin').file_browser()<cr>
nnoremap fe <cmd>lua require('telescope.builtin').diagnostics({bufnr=0})<cr>
nnoremap fl <cmd>lua require('telescope.builtin').builtin()<cr>
nnoremap fg <cmd>lua require('telescope.builtin').git_bcommits()<cr>
" Find word under cursor, all files
nnoremap ca <cmd>lua require('telescope.builtin').grep_string()<cr>
" Find word under cursor, current buffer
nnoremap cb <cmd>lua require('telescope.builtin').grep_string({search_dirs={"%:p"}})<cr>
" Search/replace string in files in quickfix list. fr - any, cr - word under cursor
nnoremap fr :cfdo %s///g \| update
nnoremap cr :cfdo %s/<C-r><C-w>//g \| update

" Startify
let g:startify_lists = [
          \ { 'type': 'files',     'header': ['   Files']            },
          \ { 'type': 'dir',       'header': ['   Current Directory '. getcwd()] },
          \ { 'type': 'sessions',  'header': ['   Sessions']       },
          \ { 'type': 'bookmarks', 'header': ['   Bookmarks']      },
          \ ]

" nvim-tree settings
lua << EOF
require'nvim-tree'.setup {
    open_on_setup = false,
    hijack_cursor = false,
    open_on_tab = true,
    disable_netrw  = false,
    hijack_netrw   = false,
    update_cwd     = false,
    respect_buf_cwd = false,
    open_on_tab = true,
    update_focused_file = {
        enable = true,
    },
    filters = {
      custom = {'.git$', 'node_modules', '.pyc$', '.pyo$', '.egg-info$', '__pycache__', '.venv', 'venv'},
      dotfiles = false,
    },
    view = {
    width = 42,
    side = 'left',
    adaptive_size = false,
  },
  renderer = {
    add_trailing = true,
    group_empty = false,
    highlight_git = true,
    highlight_opened_files = "name",
    root_folder_modifier = ":~",
    indent_markers = {
      enable = true,
      icons = {
        corner = "└ ",
        edge = "│ ",
        none = "  ",
      },
    },
    icons = {
      webdev_colors = true,
      git_placement = "before",
      padding = " ",
      symlink_arrow = " ➛ ",
      show = {
        file = true,
        folder = true,
        folder_arrow = true,
        git = true,
      },
      glyphs = {
        default = "",
        symlink = "",
        folder = {
          arrow_closed = "",
          arrow_open = "",
          default = "",
          open = "",
          empty = "",
          empty_open = "",
          symlink = "",
          symlink_open = "",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "",
          renamed = "➜",
          untracked = "★",
          deleted = "",
          ignored = "◌",
        },
      },
    },
    special_files = { "Cargo.toml", "Makefile", "README.md", "readme.md" },
  },
}
EOF

" Autoclose nvim-tree
" solution from from https://github.com/kyazdani42/nvim-tree.lua/issues/1368#issuecomment-1195557960
lua << EOF
vim.api.nvim_create_autocmd("BufEnter", {
  group = vim.api.nvim_create_augroup("NvimTreeClose", {clear = true}),
  pattern = "NvimTree_*",
  callback = function()
    local layout = vim.api.nvim_call_function("winlayout", {})
    if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then vim.cmd("confirm quit") end
  end
})
EOF

highlight NvimTreeIndentMarker guifg=#555756
nnoremap <C-n> :NvimTreeToggle<CR>

" LSP config
lua << EOF
-- Setup nvim-cmp.
local cmp = require'cmp'
-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

cmp.setup({
completion = {
    autocomplete = false, -- disable auto-completion trigger by default.
},
snippet = {
      expand = function(args)
        vim.fn["vsnip#anonymous"](args.body) -- For `vsnip` users.
      end,
},
mapping =  cmp.mapping.preset.insert({
  ['<C-u>'] = cmp.mapping(cmp.mapping.scroll_docs(-4), { 'i', 'c' }),
  ['<C-f>'] = cmp.mapping(cmp.mapping.scroll_docs(4), { 'i', 'c' }),
  ['<C-n>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
  ['<C-y>'] = cmp.config.disable, -- Specify `cmp.config.disable` if you want to remove the default `<C-y>` mapping.
  ['<C-c>'] = cmp.mapping({
    i = cmp.mapping.abort(),
    c = cmp.mapping.close(),
  }),
  ['<CR>'] = cmp.mapping.confirm({ select = false }),
}),
sources = cmp.config.sources({
  { name = 'nvim_lsp' },
  { name = 'vsnip' },
  { name = 'buffer' },
  { name = 'path' }
}),
})

-- Configure LSP
local nvim_lsp = require('lspconfig')

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
  local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
  local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

  -- Mappings.
  local opts = { noremap=true, silent=true }

  -- See `:help vim.lsp.*` for documentation on any of the below functions
  -- Optional open with: "tab split | lua command" or "vsplit | lua command"
  buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  buf_set_keymap('n', 'gj', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  buf_set_keymap('n', 'gd', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', opts)
  buf_set_keymap('n', 'gi', '<cmd>vsplit | lua vim.lsp.buf.implementation()<CR>', opts)
  buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  buf_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  buf_set_keymap('n', '<space>t', '<cmd>vsplit | lua vim.lsp.buf.type_definition()<CR>', opts)
  buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
  buf_set_keymap('n', 'gu', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.formatting()<CR>', opts)

  -- tsserver specific opts
  if client.name == "tsserver" then
        -- disable code format in tsserver
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        --buf_set_keymap("n", "<Leader>o", "<CMD>TSServerOrganizeImports<CR>", opts)
  end
end

local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Add additional capabilities supported by nvim-cmp
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities) --deprecated
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
  properties = {'documentation', 'detail', 'additionalTextEdits'}
}

-- Use a loop to conveniently call 'setup' on multiple servers and
-- map buffer local keybindings when the language server attaches
local servers = { 'pyright',
                  'rust_analyzer',
                  'gopls',
                  'tsserver',
                  'yamlls',
                  'bashls',
                  'jsonls',
                  'cssls',
                  'html',
                  'graphql',
                  'vimls' }
for _, lsp in ipairs(servers) do
  nvim_lsp[lsp].setup {
    capabilities = capabilities,
    on_attach = on_attach,
    root_dir = function(fname)
      -- useful patterns: vim.loop.cwd() or vim.fn.getcwd()
      return nvim_lsp.util.root_pattern("package.json",
                                        "tsconfig.json",
                                        "jsconfig.json",
                                        "setup.py",
                                        "setup.cfg",
                                        "pyproject.toml",
                                        "requirements.txt",
                                        "Cargo.toml",
                                        "rust-project.json",
                                        ".git/")(fname)
      or nvim_lsp.util.path.dirname(fname);
    end,
    flags = {
      debounce_text_changes = 300,
      allow_incremental_sync = true
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

-- Formatters and Linters by efm server. As alternative use null-ls
local eslint = {
  lintCommand = "eslint_d -f visualstudio --stdin --stdin-filename ${INPUT}",
  lintStdin = true,
  lintFormats = {"%f(%l,%c): %tarning %m", "%f(%l,%c): %rror %m"},
  lintIgnoreExitCode = true,
  formatCommand = "eslint_d --fix-to-stdout --stdin --stdin-filename=${INPUT}",
  formatStdin = true
}
local markdownlint = {
  -- disable line-length rule
  lintCommand = "markdownlint --disable MD013 MD034 -s",
  lintStdin = true,
  lintFormats = {"%f:%l %m", "%f:%l:%c %m", "%f: %l: %m"},
  -- formatCommand = "markdownlint --fix ${INPUT}",
  -- formatStdin = true
}
local prettier = {
  formatCommand = 'prettier --stdin-filepath ${INPUT}',
  formatStdin = true
}
-- default black line length is 88
local black = { formatCommand = 'black --line-length 79 --quiet -', formatStdin = true }
local isort = { formatCommand = 'isort --profile black --quiet -', formatStdin = true }
local shfmt = { formatCommand = 'shfmt -i 2 -ci -s -bn', formatStdin = true }

local efm_languages = {
    python = {black, isort},
    sh = {shfmt},
    yaml = {prettier},
    json = {prettier},
    markdown = {markdownlint, prettier},
    javascript = {eslint},
    javascriptreact = {eslint},
    ["javascript.jsx"] = {eslint},
    typescript = {eslint},
    typescriptreact = {eslint},
    ["typescript.tsx"] = {eslint},
    css = {prettier},
    scss = {prettier},
    sass = {prettier},
    less = {prettier},
    graphql = {prettier},
    vue = {prettier},
    html = {prettier},
    svelte = {eslint},
}

nvim_lsp.efm.setup ({
  on_attach = on_attach,
  root_dir = function(fname)
      return nvim_lsp.util.root_pattern(".git/")(fname)
      or nvim_lsp.util.path.dirname(fname);
  end,
  init_options = {
    documentFormatting = true,
    hover = false,
    documentSymbol = false,
    codeAction = false,
    completion = false
  },
  filetypes = vim.tbl_keys(efm_languages),
  settings = {
    --log_file = '~/.config/efm.log',
    languages = efm_languages,
  },
})

EOF

" TreeSitter config
lua <<EOF
require'nvim-treesitter.configs'.setup {
  ensure_installed = "all",
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = true,
  },

}
EOF
" Fix some Python operators highlighting
autocmd FileType python highlight link TSKeywordOperator Keyword
" or optional use: highlight link pythonTSKeywordOperator Keyword

" Gitsigns
lua <<EOF
require('gitsigns').setup({
  current_line_blame = false,
})
EOF
" Gitsigns diffs. See gitsigns-revision for a more complete list of ways to specify bases
" Diff against the last commit
nnoremap <silent> <leader>hl :Gitsigns diffthis ~1<CR>
" Diff against the index
nnoremap <silent> <leader>hi :Gitsigns diffthis<CR>

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

" Vista bar
nmap <F8> :Vista!!<CR>
let g:vista_default_executive = 'nvim_lsp'

" vim-doge (doc gen) keymap
" navigate TODO <Tab> <S-Tab>
let g:doge_mapping = "<Leader>s"
let g:doge_doc_standard_python = 'sphinx'

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
" let g:floaterm_autoclose=2
" nnoremap <silent> <leader>t :FloatermToggle<CR>
" tnoremap <silent> <leader>t <C-\><C-n>:FloatermToggle<CR>

" Open native terminal (same path as current opened file)
" horizontal
map <silent> <leader>th :lcd %:p:h<CR>:split \| term<CR>
" vertical
map <silent> <leader>tv :lcd %:p:h<CR>:vsplit \| term<CR>

" Open Lazygit in:
" vertical split
map <silent> <leader>g :lcd %:p:h<CR>:vsplit \| term lazygit<CR>
" vertical split maximized
map <silent> <leader>gf :lcd %:p:h<CR>:vsplit \| :MaximizerToggle<CR>:term lazygit<CR>

" Open Lazydocker in:
" vertical split
map <silent> <leader>c :vsplit \| term lazydocker<CR>
" vertical split maximized
map <silent> <leader>cf :vsplit \| :MaximizerToggle<CR> :term lazydocker<CR>

" Load .lvimrc without confirmation
let g:localvimrc_ask = 0

" Load user config
call SourceIfExists("~/.dotclinvim.vim")
