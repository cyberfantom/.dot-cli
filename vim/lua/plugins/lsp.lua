local M = {}
M.servers = {
    "pyright",
    "ruff",
    "rust_analyzer",
    "gopls",
    --"tsserver",
    "ts_ls",
    "bashls",
    "jsonls",
    "cssls",
    "html",
    "graphql",
    "vimls",
    "clangd",
    "helm_ls",
    "taplo",
    "ansiblels",
    "terraformls",
    -- LSP servers must be configured separately
    "yamlls",
    "lua_ls"
}

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
    -- buf_set_keymap('n', 'gd', '<cmd>vsplit | lua vim.lsp.buf.definition()<CR>', opts)
    -- buf_set_keymap('n', 'gi', '<cmd>vsplit | lua vim.lsp.buf.implementation()<CR>', opts)
    buf_set_keymap('n', 'gs', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
    buf_set_keymap('n', 'ge', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
    -- buf_set_keymap('n', 'gr', '<cmd>lua vim.lsp.buf.rename()<CR>', opts) -- Lspsaga implementation used
    buf_set_keymap('n', '<space>t', '<cmd>vsplit | lua vim.lsp.buf.type_definition()<CR>', opts)
    buf_set_keymap('n', '<space>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
    buf_set_keymap('n', '<space>wl', '<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>', opts)
    buf_set_keymap('n', 'gu', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
    -- buf_set_keymap('n', '<leader>f', '<cmd>lua vim.lsp.buf.format({async = true})<CR>', opts)
    buf_set_keymap('n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)

    -- tsserver specific opts
    -- if client.name == "tsserver" then
    -- if client.name == "ts_ls" then
    --     -- disable code format in tsserver
    --     client.resolved_capabilities.document_formatting = false
    --     client.resolved_capabilities.document_range_formatting = false
    --     --buf_set_keymap("n", "<Leader>o", "<CMD>TSServerOrganizeImports<CR>", opts)
    -- end
    -- ruff_lsp specific opts
    -- if client.name == "ruff" then
    --     -- disable code format in ruff_lsp
    --     client.resolved_capabilities.document_formatting = false
    --     client.resolved_capabilities.document_range_formatting = false
    -- end
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
    for _, lsp in ipairs(M.servers) do
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
                        "ansible.cfg",
                        ".ansible-lint",
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

    -- https://github.com/astral-sh/ruff-lsp/issues/384
    -- This is example how to use pyright alongside ruff-lsp
    -- Options:
    -- 1. disable all pyright analysis. Here we're losing pyright type checking (we can use mypy in this case)
    -- 2. Suppress 1st tag in diagnostics to show only ruff messages (for now some issues with this)
    -- 3. Disable special diagnostic types in pyright: some of them does not work
    -- nvim_lsp.pyright.setup {
    --     -- use second tag for diagnostics
    --     capabilities = (function()
    --         local capabilities = vim.lsp.protocol.make_client_capabilities()
    --         capabilities.textDocument.publishDiagnostics.tagSupport.valueSet = { 2 }
    --         return capabilities
    --     end)(),
    --     settings = {
    --         pyright = {
    --             -- Using Ruff's import organizer
    --             disableOrganizeImports = true,
    --         },
    --         python = {
    --             -- Ignore all files for analysis to exclusively use Ruff for linting
    --             -- analysis = {
    --             --     ignore = { '*' },
    --             -- },
    --             -- Disable diagnostic for some cases
    --             diagnosticSeverityOverrides = {
    --                 -- https://github.com/microsoft/pyright/blob/main/docs/configuration.md#type-check-diagnostics-settings
    --                 reportUndefinedVariable = "none",
    --                 reportUnusedImport = "none",
    --                 reportUnusedClass = "none",
    --                 reportUnusedFunction = "none",
    --                 reportDuplicateImport = "none",
    --             },
    --         }
    --     }
    -- }
end

-- null-ls settings
-- function M.null_ls()
--     local null_ls = require("null-ls")
--     local ruff_opts = {
--         extra_args = { "--ignore", "E501" },
--     }
--     null_ls.setup({
--         on_attach = on_attach,
--         diagnostic_config = {
--             underline = true,
--             virtual_text = false,
--             signs = true,
--             update_in_insert = true,
--             severity_sort = true,
--         },
--         sources = {
--             null_ls.builtins.code_actions.shellcheck,
--             null_ls.builtins.formatting.shfmt.with({
--                 extra_args = { "-i", "4", "-ci", "-bn", "-sr" },
--             }),
--             null_ls.builtins.formatting.prettier.with({
--                 -- exclude filetypes, use eslint with prettier plugin for this
--                 disabled_filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
--             }),
--             null_ls.builtins.diagnostics.eslint_d,
--             null_ls.builtins.code_actions.eslint_d,
--             null_ls.builtins.formatting.eslint_d,
--             null_ls.builtins.diagnostics.cppcheck, -- installing to system separately, by hands
--             null_ls.builtins.diagnostics.cpplint.with({
--                 args = { "--filter=-legal/copyright", "$FILENAME" }
--             }),
--             null_ls.builtins.formatting.astyle, -- also try https://uncrustify.sourceforge.net -- installing to system separately, by hands
--         },
--     })
-- end

function M.nvim_lint()
    local lint = require("lint")
    lint.linters_by_ft = {
        javascript = { "eslint_d" },
        typescript = { "eslint_d" },
        javascriptreact = { "eslint_d" },
        typescriptreact = { "eslint_d" },
        svelte = { "eslint_d" },
        c = { "cpplint" },
        cpp = { "cpplint" },
        markdown = { "markdownlint-cli2" },
        sh = { "shellcheck" },
        bash = { "shellcheck" }
    }

    -- cpplint options
    lint.linters.cpplint.args = { "--filter=-legal/copyright", "$FILENAME" }
    -- markdownlint_cli2 options
    local markdownlint_cli2 = require("lint/linters/markdownlint-cli2")
    markdownlint_cli2.args = { "--disable", "MD013", "MD014", "MD034" }

    local lint_augroup = vim.api.nvim_create_augroup("lint", { clear = true })

    vim.api.nvim_create_autocmd({ "BufEnter", "BufWritePost", "InsertLeave" }, {
        group = lint_augroup,
        callback = function()
            lint.try_lint()
        end,
    })
end

function M.conform()
    local conform = require("conform")
    conform.setup({
        formatters_by_ft = {
            -- lua = { "stylua" },
            -- Conform will run multiple formatters sequentially
            python = { "isort", "black" },
            markdown = { "markdownlint-cli2", "mdformat" }, -- future add "cbfmt" to list
            xml = { "xmlformatter" },
            -- Use a sub-list to run only the first available formatter
            javascript = { "prettierd", "prettier", stop_after_first = true },
            typescript = { "prettierd", "prettier", stop_after_first = true },
            typescriptreact = { "prettierd", "prettier", stop_after_first = true },
            javascriptreact = { "prettierd", "prettier", stop_after_first = true },
            svelte = { "prettierd", "prettier", stop_after_first = true },
            css = { "prettierd", "prettier", stop_after_first = true },
            html = { "prettierd", "prettier", stop_after_first = true },
            json = { "prettierd", "prettier", stop_after_first = true },
            yaml = { "prettierd", "prettier", stop_after_first = true },
            -- markdown = { "prettierd", "prettier" , stop_after_first = true },
            graphql = { "prettierd", "prettier", stop_after_first = true },
            bash = { "shfmt" },
            zsh = { "shfmt" },
            sh = { "shfmt" },
        },
        formatters = {
            isort = {
                -- Change where to find the command
                command = "isort",
                -- Adds environment args to the yamlfix formatter
                prepend_args = { "--profile", "black" },
            },
            markdownlint_cli2 = { prepend_args = { "--disable", "MD013", "MD014", "MD034" } },
            xmlformatter = { command = "xmlformat", args = { "-" }, },
            shfmt = {
                command = "shfmt",
                prepend_args = { "-i", "4", "-ci", "-bn", "-sr", "-ln", "bash" },
            },
        }
    })
    -- bind conform format key, fallback to lsp
    vim.keymap.set('n', '<leader>f', function() conform.format({ async = true, lsp_fallback = true }) end)
end

--Lspsaga setup
function M.lspsaga()
    local lspsaga = require('lspsaga')
    lspsaga.setup({
        symbol_in_winbar = { enable = false },
        lightbulb = { enable = false },
        definition = {
            keys = {
                edit = '<C-o>',
                vsplit = '<C-v>',
                split = '<C-x>',
                tabe = '<C-t>',
                close = '<ESC>'
            }
        },
        rename = {
            keys = {
                quit = '<ESC>'
            }
        },
        finder = {
            keys = {
                vsplit = '<C-v>',
                split = '<C-x>',
                tabe = '<C-t>',
                close = '<ESC>'
            }
        },
        callhierarchy = {
            keys = {
                edit = '<C-o>',
                vsplit = '<C-v>',
                split = '<C-x>',
                tabe = '<C-t>',
                close = '<ESC>'
            }
        },
    })
    -- Keymap
    vim.keymap.set('n', 'gr', '<Cmd>Lspsaga rename ++project<cr>')
    vim.keymap.set('n', 'gf', '<Cmd>:Lspsaga finder<cr>')
    vim.keymap.set('n', 'gd', '<Cmd>:Lspsaga peek_definition<cr>')
    vim.keymap.set('n', 'go', '<Cmd>:Lspsaga outgoing_calls<cr>')
    vim.keymap.set('n', 'gi', '<Cmd>:Lspsaga incoming_calls<cr>')
end

return M
