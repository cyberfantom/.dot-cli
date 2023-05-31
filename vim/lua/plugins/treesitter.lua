require 'nvim-treesitter.configs'.setup {
    ensure_installed = "all",
    highlight = {
        enable = true,
        additional_vim_regex_highlighting = true,
    },
}

-- Fix some Python operators highlighting
vim.api.nvim_create_autocmd({ "BufEnter", "BufWinEnter" }, {
    pattern = { "*.py" },
    command = "highlight link TSKeywordOperator Keyword",
})
-- Old method
-- vim.api.nvim_command('autocmd FileType python highlight link TSKeywordOperator Keyword')
