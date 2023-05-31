local M = {}

-- Use an on_attach function to only map the following keys
-- after the language server attaches to the current buffer
local on_attach = function(client, bufnr)
    local function buf_set_keymap(...) vim.api.nvim_buf_set_keymap(bufnr, ...) end
    local function buf_set_option(...) vim.api.nvim_buf_set_option(bufnr, ...) end

    -- Mappings.
    local opts = { noremap = true, silent = true }

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    -- Optional open with: "tab split | lua command" or "vsplit | lua command"
    buf_set_keymap('n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
    buf_set_keymap('n', 'gj', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
    buf_set_keymap('n', 'gd', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', opts)
    buf_set_keymap('n', 'gi', '<cmd>vsplit | lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
    buf_set_keymap('n', '<space>t', '<cmd>vsplit | lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', 'gu', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

    -- tsserver specific opts
    if client.name == "tsserver" then
        -- disable code format in tsserver
        client.resolved_capabilities.document_formatting = false
        client.resolved_capabilities.document_range_formatting = false
        --buf_set_keymap("n", "<Leader>o", "<CMD>TSServerOrganizeImports<CR>", opts)
    end
end

-- Disable LSP on some filetypes
-- vim.api.nvim_create_autocmd('Filetype', {
--     pattern = { 'NvimTree', },
--     callback = function()
--         vim.diagnostic.disable()
--     end
-- })

-- Set capabilities
local capabilities = vim.lsp.protocol.make_client_capabilities()
-- Add additional capabilities supported by nvim-cmp
-- capabilities = require('cmp_nvim_lsp').update_capabilities(capabilities) --deprecated
capabilities = require('cmp_nvim_lsp').default_capabilities(capabilities)
capabilities.textDocument.completion.completionItem.snippetSupport = true
capabilities.textDocument.completion.completionItem.resolveSupport = {
    properties = { 'documentation', 'detail', 'additionalTextEdits' }
}
capabilities.offsetEncoding = { "utf-16" }

function M.lsp()
    local nvim_lsp = require('lspconfig')
    -- Use a loop to conveniently call 'setup' on multiple servers and
    -- map buffer local keybindings when the language server attaches
    local servers = {
        'pyright',
        'rust_analyzer',
        'gopls',
        'tsserver',
        'bashls',
        'jsonls',
        'cssls',
        'html',
        'graphql',
        'vimls',
        'clangd'
    }
    for _, lsp in ipairs(servers) do
        nvim_lsp[lsp].setup {
            capabilities = capabilities,
            on_attach = on_attach,
            -- offset_encoding = "utf-8",
            root_dir = function(fname)
                -- useful patterns: vim.loop.cwd() or vim.fn.getcwd()
                return nvim_lsp.util.root_pattern("package.json",
                        "tsconfig.json",
                        "jsconfig.json",
                        "setup.py",
                        "setup.cfg",
                        "pyproject.toml",
                        "requirements.txt",
                        "Cargo.toml",
                        "rust-project.json",
                        ".git/")(fname)
                    or nvim_lsp.util.path.dirname(fname);
            end,
            flags = {
                debounce_text_changes = 300,
                allow_incremental_sync = true
            }
        }
    end

    -- disable inline diagnostics messages
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
        vim.lsp.diagnostic.on_publish_diagnostics, {
            virtual_text = false,
            signs = true,
            update_in_insert = true
        }
    )

    -- yamlls settings
    nvim_lsp.yamlls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            yaml = {
                format = {
                    enable = true
                },
                keyOrdering = false,
                completion = true,
                schemaStore = {
                    enable = true
                },
            },
        },
    }

    -- lua_ls settings
    nvim_lsp.lua_ls.setup {
        capabilities = capabilities,
        on_attach = on_attach,
        settings = {
            Lua = {
                diagnostics = {
                    -- Get the language server to recognize the `vim` global
                    globals = { 'vim' },
                },
                -- Do not send telemetry data containing a randomized but unique identifier
                telemetry = {
                    enable = false,
                },
            },
        },
    }
end

-- null-ls settings
function M.null_ls()
    local null_ls = require("null-ls")
    local ruff_opts = {
        extra_args = { "--ignore", "E501" },
    }
    null_ls.setup({
        on_attach = on_attach,
        diagnostic_config = {
            underline = true,
            virtual_text = false,
            signs = true,
            update_in_insert = true,
            severity_sort = true,
        },
        sources = {
            null_ls.builtins.code_actions.shellcheck,
            -- null_ls.builtins.diagnostics.shellcheck, -- implemented in bashls
            null_ls.builtins.formatting.shfmt.with({
                extra_args = { "-i", "4", "-ci", "-bn", "-sr" },
            }),
            null_ls.builtins.formatting.prettier.with({
                -- exclude filetypes, use eslint with prettier plugin for this
                disabled_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
            }),
            null_ls.builtins.diagnostics.eslint_d,
            null_ls.builtins.code_actions.eslint_d,
            null_ls.builtins.formatting.eslint_d,
            null_ls.builtins.diagnostics.cppcheck,
            null_ls.builtins.diagnostics.cpplint.with({
                args = { "--filter=-legal/copyright", "$FILENAME" }
            }),
            null_ls.builtins.formatting.astyle, -- also try https://uncrustify.sourceforge.net
            null_ls.builtins.diagnostics.markdownlint.with({
                extra_args = { "--disable", "MD013", "MD014", "MD034" },
            }),
            null_ls.builtins.formatting.black.with({
                extra_args = { "--line-length", "79" },
            }),
            null_ls.builtins.formatting.isort.with({
                extra_args = { "--profile", "black" },
            }),
            null_ls.builtins.diagnostics.ruff.with(ruff_opts),
            null_ls.builtins.formatting.ruff.with(ruff_opts),
        },
    })
end

return M
