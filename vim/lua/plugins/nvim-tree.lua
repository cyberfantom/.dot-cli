local api = require("nvim-tree.api")
local function on_attach(bufnr)
    local function opts(desc)
        return { desc = 'nvim-tree: ' .. desc, buffer = bufnr, noremap = true, silent = true, nowait = true }
    end

    -- Examples
    -- copy default mappings here from defaults in next section
    -- vim.keymap.set('n', '<C-]>', api.tree.change_root_to_node,          opts('CD'))
    -- vim.keymap.set('n', '<C-e>', api.node.open.replace_tree_buffer,     opts('Open: In Place'))
    ---
    -- Use all default mappings
    api.config.mappings.default_on_attach(bufnr)

    -- remove a default
    -- vim.keymap.del('n', '<C-]>', { buffer = bufnr })

    -- Open file by <Enter> keypress in new buffer or jump to existing
    vim.keymap.set('n', '<CR>',
        function()
            api.node.open.drop()
        end,
        opts('Open-Drop')
    )
    -- Open file by <C-t> keypress in new tab or jump to existing
    vim.keymap.set('n', '<C-t>',
        function()
            api.node.open.tab_drop()
        end,
        opts('Open-Tab-Drop')
    )
    -- @TODO: open preview and focus on opened buffer.
    -- api.node.open.preview()
    -- vim.cmd([[wincmd w]])
end

require 'nvim-tree'.setup {
    on_attach                          = on_attach,
    hijack_cursor                      = false,
    hijack_unnamed_buffer_when_opening = false,
    disable_netrw                      = false,
    hijack_netrw                       = false,
    update_cwd                         = false,
    respect_buf_cwd                    = false,
    update_focused_file                = {
        enable = true,
    },
    modified                           = {
        enable = true,
        show_on_open_dirs = false
    },
    tab                                = {
        sync = {
            open = true,
            close = true
        },
    },
    filters                            = {
        custom = { '.git$', 'node_modules', '.pyc$', '.pyo$', '.egg-info$', '__pycache__', '.venv', 'venv' },
        dotfiles = false,
    },
    view                               = {
        width = 42,
        side = 'right',
        adaptive_size = false,
    },
    renderer                           = {
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
    git                                = {
        enable = true,
        ignore = false,
        show_on_dirs = true,
        show_on_open_dirs = true,
        timeout = 200,
    },
}
-- Autoclose nvim-tree
-- solution from from https://github.com/kyazdani42/nvim-tree.lua/issues/1368#issuecomment-1195557960
vim.api.nvim_create_autocmd("BufEnter", {
    group = vim.api.nvim_create_augroup("NvimTreeClose", { clear = true }),
    pattern = "NvimTree_*",
    callback = function()
        local layout = vim.api.nvim_call_function("winlayout", {})
        if layout[1] == "leaf" and vim.api.nvim_buf_get_option(vim.api.nvim_win_get_buf(layout[2]), "filetype") == "NvimTree" and layout[3] == nil then
            vim.cmd("confirm quit")
        end
    end
})

-- Keymap
vim.keymap.set('n', '<leader>e', api.tree.toggle)

-- Fix highlight
-- vim.api.nvim_set_hl(0, "NvimTreeIndentMarker", { fg = "#555756", })
