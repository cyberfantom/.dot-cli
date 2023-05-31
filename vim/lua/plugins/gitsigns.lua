require('gitsigns').setup({
    current_line_blame = false,
})

-- Keymap
-- Gitsigns diffs. See gitsigns-revision for a more complete list of ways to specify bases
-- Diff against the last commit
vim.keymap.set('n', '<leader>hl', '<cmd>Gitsigns diffthis ~1<CR>', {silent = true })
-- Diff against the index
vim.keymap.set('n', '<leader>hi', '<cmd>:Gitsigns diffthis<CR>', {silent = true })
-- Toggle git signs
vim.keymap.set('n', '<leader>ht', '<cmd>:Gitsigns toggle_signs<CR>', {silent = true })
-- Refresh git signs in all bufferes
vim.keymap.set('n', '<leader>hr', '<cmd>:Gitsigns refresh<CR>', {silent = true })
