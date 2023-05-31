require('lualine').setup {
    options = {
        icons_enabled = true,
        theme = 'auto',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = {
            statusline = { "vista_kind" },
            winbar = { "vista_kind" },
        },
        ignore_focus = { "NvimTree", "vista_kind" },
        always_divide_middle = true,
        globalstatus = true,
        refresh = {
            statusline = 1000,
            tabline = 1000,
            winbar = 1000,
        }
    },
    sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = {
            { 'filename', path = 1 },
        },
        lualine_x = { 'encoding', 'fileformat', 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' }
    },
    inactive_sections = {
        lualine_a = {},
        lualine_b = {},
        lualine_c = { 'filename' },
        lualine_x = { 'location' },
        lualine_y = {},
        lualine_z = {}
    },
    tabline = {
        -- lualine_a = {
        --     {
        --         "tabs",
        --         separator = { left = '', right = '' },
        --         right_padding = 2,
        --         max_length = vim.o.columns / 3,
        --         mode = 2,
        --         symbols = { alternate_file = "" },
        --         fmt = function(name, context)
        --             -- Show + if buffer is modified in tab
        --             local buflist = vim.fn.tabpagebuflist(context.tabnr)
        --             local winnr = vim.fn.tabpagewinnr(context.tabnr)
        --             local bufnr = buflist[winnr]
        --             local mod = vim.fn.getbufvar(bufnr, '&mod')

        --             return name .. (mod == 1 and ' +' or '')
        --         end
        --     },
        -- },
    },
    winbar = {},
    inactive_winbar = {},
    extensions = { 'nvim-tree', 'quickfix' }
}
