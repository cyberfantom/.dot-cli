local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not vim.loop.fs_stat(lazypath) then
    vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "https://github.com/folke/lazy.nvim.git",
        "--branch=stable", -- latest stable release
        lazypath,
    })
end
vim.opt.rtp:prepend(lazypath)

local plugins = {
    {
        'folke/tokyonight.nvim',
        config = function() require('colorscheme').tokyonight() end,
        lazy = true
    },
    {
        'sainnhe/gruvbox-material',
        config = function() require('colorscheme').gruvbox_material() end,
        lazy = true
    },
    {
        'olimorris/onedarkpro.nvim',
        priority = 1000, -- Ensure it loads first
        config = function() require('colorscheme').onedarkpro() end,
    },
    {
        'EdenEast/nightfox.nvim',
        config = function() require('colorscheme').nightfox() end,
    },
    {
        'rebelot/kanagawa.nvim',
        config = function() require('colorscheme').kanagawa() end,
    },
    {
        'catppuccin/nvim',
        config = function() require('colorscheme').catppuccin() end,
        name = 'catppuccin',
        lazy = true
    },
    {
        'nvim-treesitter/nvim-treesitter',
        config = function() require('plugins/treesitter') end,
        build = ':TSUpdate'
    },
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        config = function() require('plugins/harpoon') end,
    },
    {
        "williamboman/mason.nvim",
        cmd = { "Mason", "MasonInstall", "MasonUpdate" },
        config = function() require("mason").setup() end,
        dependencies = { "williamboman/mason-lspconfig.nvim", },
    },
    {
        "WhoIsSethDaniel/mason-tool-installer.nvim",
        config = function() require('plugins/mason-tool-installer') end,
    },
    {
        'neovim/nvim-lspconfig',
        cmd = 'LspInfo',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function() require('plugins/lsp').lsp() end,
        lazy = true
    },
    {
        'nvimdev/lspsaga.nvim',
        config = function() require('plugins/lsp').lspsaga() end,
        event = { 'LspAttach', },
        dependencies = {
            'nvim-treesitter/nvim-treesitter', -- optional
            'nvim-tree/nvim-web-devicons',     -- optional
        }
    },
    -- {
    --     'jose-elias-alvarez/null-ls.nvim',
    --     cmd = 'NullLsInfo',
    --     event = { 'BufReadPre', 'BufNewFile' },
    --     config = function() require('plugins/lsp').null_ls() end,
    --     lazy = true
    -- },
    {
        'mfussenegger/nvim-lint',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function() require('plugins/lsp').nvim_lint() end,
        lazy = true
    },
    {
        'stevearc/conform.nvim',
        event = { 'BufReadPre', 'BufNewFile' },
        config = function() require('plugins/lsp').conform() end,
        lazy = true
    },
    {
        'hrsh7th/nvim-cmp',
        event = 'InsertEnter',
        config = function() require('plugins/cmp') end,
        dependencies = {
            'hrsh7th/cmp-nvim-lsp',
            'hrsh7th/cmp-buffer',
            'hrsh7th/cmp-path',
            'hrsh7th/cmp-vsnip',
            'hrsh7th/vim-vsnip',
        },
        lazy = true
    },
    {
        'nvim-lua/plenary.nvim',
        lazy = true
    },
    {
        'nvim-telescope/telescope.nvim',
        config = function() require('plugins/telescope') end,
        -- cmd = 'Telescope',
    },
    {
        'kyazdani42/nvim-web-devicons',
        lazy = true
    },
    {
        'kyazdani42/nvim-tree.lua',
        config = function() require('plugins/nvim-tree') end,
        -- cmd = { "NvimTreeToggle", "NvimTreeOpen", "NvimTreeFocus", "NvimTreeFindFileToggle" },
    },
    {
        'iamcco/markdown-preview.nvim',
        ft = { 'markdown' },
        build = function() vim.fn["mkdp#util#install"]() end,
        lazy = true
    },
    {
        'simrat39/symbols-outline.nvim',
        cmd = 'SymbolsOutline',
        event = 'LspAttach',
        config = function() require("plugins/symbols-outline") end,
        lazy = true
    },
    {
        'kevinhwang91/nvim-bqf',
        ft = { 'qf' },
        lazy = true
    },
    { 'nvim-lualine/lualine.nvim',           config = function() require('plugins/lualine') end, },
    { 'akinsho/bufferline.nvim',             config = function() require('plugins/bufferline') end, },
    { 'RRethy/vim-illuminate',               config = function() require('plugins/illuminate') end, },
    { 'lukas-reineke/indent-blankline.nvim', config = function() require('plugins/indent-blankline') end, main = "ibl", },
    { 'mhinz/vim-startify',                  config = function() require('plugins/startify') end, },
    { 'lewis6991/gitsigns.nvim',             config = function() require('plugins/gitsigns') end, },
    { 'danymat/neogen',                      config = function() require('plugins/neogen') end, },
    { 'numToStr/Comment.nvim',               config = function() require('Comment').setup() end, },
    { 'christoomey/vim-system-copy' },
    { 'szw/vim-maximizer' },
    { 'tmhedberg/SimpylFold' },
    { 'psliwka/vim-smoothie' },
    { 'editorconfig/editorconfig-vim' },
    { 'tpope/vim-surround' },
    -- { 'sheerun/vim-polyglot' }

}

require("lazy").setup(plugins)
