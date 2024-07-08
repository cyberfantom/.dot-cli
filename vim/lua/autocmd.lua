-- Detect Helm files and add custom filetype 'helm'
-- Links:
-- https://github.com/towolf/vim-helm/blob/master/ftdetect/helm.vim
-- https://github.com/neovim/nvim-lspconfig/issues/2252
vim.api.nvim_create_autocmd({ 'BufNewFile', 'BufRead' }, {
    pattern = { "*/templates/*.yaml", "*/templates/*.tpl", "*.gotmpl", "helmfile*.yaml" },
    callback = function()
        vim.opt_local.filetype = 'helm'
    end
})
-- Use {{/* */}} as comments for helm files
vim.api.nvim_create_autocmd({ "FileType" }, {
    pattern = { "helm" },
    callback = function(ev)
        vim.bo[ev.buf].commentstring = "{{/*\\ %s\\ */}}"
    end,
})
