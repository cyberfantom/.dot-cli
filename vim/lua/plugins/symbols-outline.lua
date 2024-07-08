require("symbols-outline").setup({ auto_preview = false, })
local opts = { noremap = true, silent = true }
vim.api.nvim_set_keymap("n", "<leader>o", ":SymbolsOutline<CR>", opts)
