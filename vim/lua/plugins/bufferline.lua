local bufferline = require('bufferline')
bufferline.setup {
    options = {
        mode = "tabs",
        numbers = "ordinal",
        separator_style = 'slant',
        themable = true,
        style_preset = bufferline.style_preset.no_italic,
        always_show_bufferline = false,
        show_buffer_close_icons = false,
        show_close_icon = false,
        color_icons = true,
        show_tab_indicators = false,
        enforce_regular_tabs = true,
        custom_filter = function(buf, buf_nums)
            -- filter out filetypes you don't want to see
            local ft = { "NvimTree", "vista_kind", "Outline" }
            for _, buf_ft in ipairs(ft) do
                if vim.bo[buf].filetype == buf_ft then
                    return false
                end
            end
            return true
            --
            -- Dont show Nvim Tree buffers in the bufferline
            -- if vim.bo[buf].filetype ~= "NvimTree" then
            --     return true
            -- end
            --   -- filter out by buffer name
            --   if vim.fn.bufname(buf_number) ~= "<buffer-name-I-dont-want>" then
            --     return true
            --   end
            --   -- filter out based on arbitrary rules
            --   -- e.g. filter out vim wiki buffer from tabline in your work repo
            --   if vim.fn.getcwd() == "<work-repo>" and vim.bo[buf_number].filetype ~= "wiki" then
            --     return true
            --   end
            -- filter out by it's index number in list (don't show first buffer)
            -- if buf_numbers[1] ~= buf_number then
            --     return true
            -- end
        end,
        offsets = {
            {
                filetype = "undotree",
                text = "Undotree",
                highlight = "PanelHeading",
                padding = 1,
            },
            {
                filetype = "NvimTree",
                text = "File Explorer",
                highlight = "PanelHeading",
                padding = 1,
            },
            {
                filetype = "DiffviewFiles",
                text = "Diff View",
                highlight = "PanelHeading",
                padding = 1,
            },
            {
                filetype = "flutterToolsOutline",
                text = "Flutter Outline",
                highlight = "PanelHeading",
            },
            {
                filetype = "lazy",
                text = "Lazy",
                highlight = "PanelHeading",
                padding = 1,
            },
        },
    },
}
