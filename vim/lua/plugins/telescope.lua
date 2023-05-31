require('telescope').setup {
    defaults = {
        vimgrep_arguments = {
            'rg',
            '--color=never',
            '--no-heading',
            '--with-filename',
            '--line-number',
            '--column',
            '--smart-case'
        },
    }
}

-- Keymap
local builtin = require('telescope.builtin')
-- Fuzzy find files
vim.keymap.set('n', 'ff', builtin.find_files)
-- Live grep all project files
vim.keymap.set('n', 'fa', builtin.live_grep)
-- Current buffer find without fuzzy algorytm, works same as live_grep
-- vim.keymap.set('n', 'fb', function() builtin.live_grep({ search_dirs={"%:p"}}) end)
-- Fuzzy find text in current buffer
vim.keymap.set('n', 'fb',
    function() builtin.current_buffer_fuzzy_find({ prompt_title = "Current Buffer Find",
            sorter = require('telescope.sorters').get_substr_matcher() }) end)
-- LSP diagnostics
vim.keymap.set('n', 'fe', function() builtin.diagnostics({ bufnr = 0 }) end)
-- List all builtin functions
vim.keymap.set('n', 'fl', builtin.builtin)
-- Current buffer commits
vim.keymap.set('n', 'fg', builtin.git_bcommits)
-- Opened buffers
vim.keymap.set('n', 'fo', builtin.buffers)
-- Find word under cursor, all files
vim.keymap.set('n', 'ca', builtin.grep_string)
-- Find word under cursor, current buffer
vim.keymap.set('n', 'cb', function() builtin.grep_string({ search_dirs = { "%:p" } }) end)
