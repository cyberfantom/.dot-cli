vim.opt.lazyredraw = true
vim.opt.ttyfast = true
vim.opt.hidden = false
vim.opt.autowrite = false
-- vim.opt.filetype = 'off'
-- vim.opt.writedelay = 1

-- Disable vim-poliglot features and languages in favor of Treesitter
vim.g.polyglot_disabled = { 'sensible', 'autoindent',
    'c', 'cpp', 'css', 'dockerfile', 'docker-compose', 'diff', 'erlang', 'gitignore',
    'go', 'graphql', 'html', 'java', 'javascript', 'javascriptreact',
    'jsx', 'json5', 'json', 'jsx', 'kotlin', 'lua', 'markdown', 'make', 'perl',
    'php', 'python', 'rust', 'sh', 'sql', 'terraform', 'toml', 'typescript',
    'typescriptreact', 'tsx', 'vue', 'vim', 'yaml' }

-- Disable reindenting of the current line in insert mode
vim.api.nvim_create_autocmd({ "BufEnter" }, {
    pattern = { "*" },
    command = "set indentexpr=",
})

-- Terminal config.
vim.cmd([[
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
]])
