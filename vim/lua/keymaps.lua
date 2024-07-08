local opts = { noremap = true, silent = true }

-- Search/replace string in files in quickfix list. fr - any, cr - word under cursor
vim.api.nvim_set_keymap("n", "fr", ":cfdo %s///g <Bar> update", opts)
vim.api.nvim_set_keymap("n", "cr", ":cfdo %s/<C-r><C-w>//g <Bar> update", opts)

-- Preview/Toggle markdown in browser
vim.api.nvim_set_keymap("n", "<leader>m", "<Plug>MarkdownPreviewToggle", { noremap = false, silent = true })

-- Open native terminal (same path as current opened file)
-- horizontal
vim.api.nvim_set_keymap("n", "<leader>th", ":lcd %:p:h<CR>:split <Bar> term<CR>", opts)
-- vertical
vim.api.nvim_set_keymap("n", "<leader>tv", ":lcd %:p:h<CR>:vsplit <Bar> term<CR>", opts)

-- Open Lazygit in:
-- vertical split
vim.api.nvim_set_keymap("n", "<leader>g", ":lcd %:p:h<CR>:vsplit <Bar> term lazygit<CR>", opts)
-- vertical split maximized
vim.api.nvim_set_keymap("n", "<leader>gf", ":lcd %:p:h<CR>:vsplit <Bar> :MaximizerToggle<CR>:term lazygit<CR>", opts)

-- Open Lazydocker in:
-- vertical split
vim.api.nvim_set_keymap("n", "<leader>c", ":vsplit <Bar> term lazydocker<CR>", opts)
-- vertical split maximized
vim.api.nvim_set_keymap("n", "<leader>cf", ":vsplit <Bar> :MaximizerToggle<CR> :term lazydocker<CR>", opts)

-- DAP
vim.api.nvim_set_keymap("n", "<leader>db", ":DapToggleBreakpoint <CR>", opts)
vim.api.nvim_set_keymap("n", "<leader>dpr", "<cmd> lua require('dap-python').test_method()<CR>", opts)
