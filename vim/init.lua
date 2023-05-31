package.path = os.getenv('HOME') .. "/.dot-cli/vim/lua/?.lua;" .. package.path
-- Options (loads before plugins)
require('options')
-- Plugins
require('plugins')
-- Base vim config
vim.cmd([[ source ~/.dot-cli/vim/viml/base.vim ]])
-- Colorscheme
require('colorscheme').set('gruvbox-material')
-- Keymaps
require('keymaps')
-- Local user config.
vim.cmd([[ call SourceIfExists("~/.dotclinvim.vim") ]])
