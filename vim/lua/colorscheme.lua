local M = {}

-- gruvbox-material config for sainnhe/gruvbox-material
function M.gruvbox_material()
    vim.g.gruvbox_material_background = 'medium' -- hard, medium, soft
    vim.g.gruvbox_material_foreground = 'mix'    -- material, mix, original
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_better_performance = 1
end

-- catppuccin config
function M.catppuccin()
    require("catppuccin").setup({
        flavour = "macchiato",       -- latte, frappe, macchiato, mocha
        styles = {                   -- Handles the styles of general hi groups (see `:h highlight-args`):
            comments = { "italic" }, -- Change the style of comments
            conditionals = {},
            loops = {},
            functions = { "bold" },
            keywords = {},
            strings = {},
            variables = {},
            numbers = {},
            booleans = {},
            properties = {},
            types = {},
            operators = {},
            -- miscs = {}, -- Uncomment to turn off hard-coded styles
        },
        color_overrides = {},
        custom_highlights = {},
        default_integrations = true,
        integrations = {
            cmp = true,
            gitsigns = true,
            nvimtree = true,
            treesitter = true,
            notify = false,
            harpoon = true,
            indent_blankline = {
                enabled = true,
                scope_color = "", -- catppuccin color (eg. `lavender`) Default: text
                colored_indent_levels = false,
            },
            dap_ui = true,
            mini = {
                enabled = true,
                indentscope_color = "",
            },
            native_lsp = {
                enabled = true,
                virtual_text = {
                    errors = { "italic" },
                    hints = { "italic" },
                    warnings = { "italic" },
                    information = { "italic" },
                },
                underlines = {
                    errors = { "underline" },
                    hints = { "underline" },
                    warnings = { "underline" },
                    information = { "underline" },
                },
                inlay_hints = {
                    background = true,
                },
            },
            telescope = {
                enabled = true,
            },
            illuminate = {
                enabled = true,
                lsp = true
            }
            -- For more plugins integrations please scroll down (https://github.com/catppuccin/nvim#integrations)
        },
    })
end

-- tokyonight config for folke/tokyonight.nvim
function M.tokyonight()
    require("tokyonight").setup({
        style = "storm",        -- The theme comes in three styles, `storm`, `moon`, a darker variant `night` and `day`
        light_style = "day",    -- The theme is used when the background is set to light
        transparent = false,    -- Enable this to disable setting the background color
        terminal_colors = true, -- Configure the colors used when opening a `:terminal` in Neovim
        styles = {
            -- Style to be applied to different syntax groups
            -- Value is any valid attr-list value for `:help nvim_set_hl`
            comments = { italic = true },
            keywords = { italic = false },
            functions = { bold = true },
            variables = {},
            -- Background styles. Can be "dark", "transparent" or "normal"
            sidebars = "dark", -- style for sidebars, see below
            floats = "dark",   -- style for floating windows
        },
        sidebars = { "qf", "help", "vista_kind", "NvimTree", "terminal" },
        hide_inactive_statusline = false,
        dim_inactive = false,
        lualine_bold = false,
    })
end

-- onedark pro config for navarasu/onedark.nvim
function M.onedark()
    require("onedark").setup({
        style = 'dark', -- Default theme style. Choose between 'dark', 'darker', 'cool', 'deep', 'warm', 'warmer' and 'light'
        code_style = {
            comments = 'italic',
            keywords = 'none',
            functions = 'bold',
            strings = 'none',
            variables = 'none'
        },
        -- Plugins Config --
        diagnostics = {
            darker = true,     -- darker colors for diagnostic
            undercurl = true,  -- use undercurl instead of underline for diagnostics
            background = true, -- use background color for virtual text
        },
    })
end

-- onedarkpro pro config for olimorris/onedarkpro.nvim
function M.onedarkpro()
    require("onedarkpro").setup({
        styles = {
            types = "NONE",
            methods = "bold",
            numbers = "NONE",
            strings = "NONE",
            comments = "italic",
            keywords = "NONE",
            constants = "NONE",
            functions = "bold",
            operators = "NONE",
            variables = "NONE",
            parameters = "italic",
            conditionals = "NONE",
            virtual_text = "NONE",
        },
        options = {
            cursorline = true,
            highlight_inactive_windows = false
        }
    })
end

-- nightfox config for EdenEast/nightfox.nvim
function M.nightfox()
    require('nightfox').setup({
        options = {
            styles = {               -- Style to be applied to different syntax groups
                comments = "italic", -- Value is any valid attr-list value `:help attr-list`
                conditionals = "NONE",
                constants = "NONE",
                functions = "bold",
                keywords = "NONE",
                numbers = "NONE",
                operators = "NONE",
                strings = "NONE",
                types = "NONE",
                variables = "NONE",
            },
        }
    })
end

-- nightfox config for EdenEast/nightfox.nvim
function M.kanagawa()
    require('kanagawa').setup({
        -- compile = false, -- enable compiling the colorscheme
        undercurl = true, -- enable undercurls
        commentStyle = { italic = true },
        functionStyle = { bold = true },
        keywordStyle = { italic = false },
        statementStyle = { bold = true },
        typeStyle = {},
        transparent = false,   -- do not set background color
        dimInactive = false,   -- dim inactive window `:h hl-NormalNC`
        terminalColors = true, -- define vim.g.terminal_color_{0,17}
        colors = {             -- add/modify theme and palette colors
            palette = {},
            theme = { wave = {}, lotus = {}, dragon = {}, all = {} },
        },
        overrides = function(colors) -- add/modify highlights
            return {}
        end,
        theme = "wave",    -- Load "wave" theme when 'background' option is not set
        background = {     -- map the value of 'background' option to a theme
            dark = "wave", -- try "dragon" !
            light = "lotus"
        },
    })
end

-- set colorscheme
function M.set(colorscheme)
    vim.cmd('silent! colorscheme ' .. colorscheme)
end

return M
