require("ibl").setup {
    indent = {
        char = "│",
    },
    scope = {
        enabled = true,
        char = "│",
        show_start = false,
        show_end = false,
        include = {
            node_type = { rust = { "*" } },
        },
        exclude = {
            language = { "python" },
        },
    },
    exclude = {
        filetypes = {
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
    },
}

--  Replaces the first indentation guide for space indentation with a normal space.
local hooks = require "ibl.hooks"
hooks.register(
    hooks.type.WHITESPACE,
    hooks.builtin.hide_first_space_indent_level
)

-- Highlight customization
vim.api.nvim_set_hl(0, "IndentBlanklineContextChar", { fg = "#b8bb26", nocombine = true })
vim.api.nvim_set_hl(0, "IndentBlanklineContextStart", { sp = "#00FF00", underline = true })
