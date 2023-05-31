require('neogen').setup {
    enabled = true,
    languages = {
        python = {
            template = {
                annotation_convention = "reST"
            }
        },
    }
}

local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<Leader>s", ":lua require('neogen').generate()<CR>", opts)
