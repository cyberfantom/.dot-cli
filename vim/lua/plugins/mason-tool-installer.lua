local servers = require('plugins/lsp').servers
local tools = {
    -- linters, formatters
    "black",
    -- "ruff",
    "isort",
    "cpplint",
    "prettier",
    "eslint_d",
    "markdownlint-cli2",
    "mdformat",
    "shfmt",
    "shellcheck",
    "cbfmt",
    "xmlformatter"
}

local function table_merge(t1, t2)
    for _, v in ipairs(t2) do
        table.insert(t1, v)
    end

    return t1
end

local _ensure_installed = {}
table_merge(_ensure_installed, servers)
table_merge(_ensure_installed, tools)
require('mason-tool-installer').setup {

    -- a list of all tools you want to ensure are installed upon
    -- start
    ensure_installed = _ensure_installed,

    -- if set to true this will check each tool for updates. If updates
    -- are available the tool will be updated. This setting does not
    -- affect :MasonToolsUpdate or :MasonToolsInstall.
    -- Default: false
    auto_update = false,

    -- automatically install / update on startup. If set to false nothing
    -- will happen on startup. You can use :MasonToolsInstall or
    -- :MasonToolsUpdate to install tools and check for updates.
    -- Default: true
    run_on_start = true,

    -- set a delay (in ms) before the installation starts. This is only
    -- effective if run_on_start is set to true.
    -- e.g.: 5000 = 5 second delay, 10000 = 10 second delay, etc...
    -- Default: 0
    start_delay = 3000, -- 3 second delay

    -- Only attempt to install if 'debounce_hours' number of hours has
    -- elapsed since the last time Neovim was started. This stores a
    -- timestamp in a file named stdpath('data')/mason-tool-installer-debounce.
    -- This is only relevant when you are using 'run_on_start'. It has no
    -- effect when running manually via ':MasonToolsInstall' etc....
    -- Default: nil
    -- debounce_hours = 5, -- at least 5 hours between attempts to install/update
}
