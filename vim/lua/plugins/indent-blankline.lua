require("indent_blankline").setup {
    -- this chars useful with 'show_current_context_start' enabled to do proper corners
    -- char = "▏",
    -- context_char = "▏",
    char = "│",
    context_char = "│",
    show_current_context = true,
    show_current_context_start = false,
    use_treesitter = true,
    show_trailing_blankline_indent = false,
    show_first_indent_level = false,
    max_indent_increase = 1,
    filetype_exclude = {
        "help",
        "terminal",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "startify",
        "dashboard",
        "lazy",
        "neogitstatus",
        "NvimTree",
        "Trouble",
        "text",
        "lspinfo",
        "packer",
        "checkhealth",
    },
}

-- Highlight customization
vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#b8bb26", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineContextStart", { sp = "#00FF00", underline = true })

-- Keymap
vim.keymap.set('n', '<C-i>', ':IndentBlanklineToggle<CR>')
