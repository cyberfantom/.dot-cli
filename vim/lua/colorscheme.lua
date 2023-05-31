local M = {}

-- gruvbox-material config
function M.gruvbox_material()
    vim.g.gruvbox_material_background = 'medium'
    vim.g.gruvbox_material_foreground = 'material'
    vim.g.gruvbox_material_enable_bold = 1
    vim.g.gruvbox_material_better_performance = 1
end

-- tokyonight config
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

-- set colorscheme
function M.set(colorscheme)
    vim.cmd('silent! colorscheme ' .. colorscheme)
end

return M
