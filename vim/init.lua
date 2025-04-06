package.path = os.getenv('HOME') .. "/.dot-cli/vim/lua/?.lua;" .. package.path
-- disable deprecated messages
-- vim.deprecate = function() end
-- Options (loads before plugins)
require('options')
-- Autocmds
require('autocmd')
-- Plugins
require('plugins')
-- Base vim config
vim.cmd([[ source ~/.dot-cli/vim/viml/base.vim ]])
-- Colorscheme
--
-- gruvbox-material | onedark | tokyonight | catppuccin
-- nightfox/dayfox/dawnfox/duskfox/nordfox/terafox/carbonfox | kanagawa
require('colorscheme').set('onedark')
-- Keymaps
require('keymaps')
-- Local user config.
vim.cmd([[ call SourceIfExists("~/.dotclinvim.vim") ]])
