-- This function gets called by the plugin when a new result from fd is received
-- You can change the filename displayed here to what you like.
-- Here in the example for linux/mac we replace the home directory with '~' and remove the /bin/python part.
local function shorter_name(filename)
    return filename:gsub(os.getenv("HOME"), "~"):gsub("/bin/python", "")
end

local venv_selector = require('venv-selector')
local opts = { noremap = true, silent = true }
venv_selector.setup {
    options = {
        -- If you put the callback here as a global option, its used for all searches (including the default ones by the plugin)
        on_telescope_result_callback = shorter_name,
        require_lsp_activation = false,
        notify_user_on_venv_activation = true,
        search_timeout = 10,
    },
    search = {
        -- Find git root dir (project root by default)
        git_root = {
            command = '$FD /bin/python$ "$(git rev-parse --show-toplevel)" --full-path --color never -E /proc -HI -a -L',
            on_telescope_result_callback = shorter_name
        },
        --
        -- Find venv with default "find" tool
        -- find_dot_venv = {
        --     command = 'source $SHELL_FUNC_PATH; $FD /bin/python$ "$(echo "$(findup -name ".venv" -type d)")" --full-path --color never -E /proc -HI -a -L',
        --     on_telescope_result_callback = shorter_name
        -- },
        -- find_venv = {
        --     command = 'source $SHELL_FUNC_PATH; $FD /bin/python$ "$(echo "$(findup -name "venv" -type d)")" --full-path --color never -E /proc -HI -a -L',
        --     on_telescope_result_callback = shorter_name
        -- },
        -- find_pyproject = {
        --     command = 'source $SHELL_FUNC_PATH; $FD /bin/python$ "$(dirname -- "$(echo "$(findup -name "pyproject.toml" -type f)")")" --full-path --color never -E /proc -HI -a -L',
        --     on_telescope_result_callback = shorter_name
        -- },
        fd_dot_venv = {
            command = 'source $SHELL_FUNC_PATH; $FD /bin/python$ "$(echo "$(fdup -g ".venv" -t d)")" --full-path --color never -E /proc -HI -a -L',
            on_telescope_result_callback = shorter_name
        },
        fd_venv = {
            command = 'source $SHELL_FUNC_PATH; $FD /bin/python$ "$(echo "$(fdup -g "venv" -t d)")" --full-path --color never -E /proc -HI -a -L',
            on_telescope_result_callback = shorter_name
        },
        fd_pyproject = {
            command = 'source $SHELL_FUNC_PATH; $FD /bin/python$ "$(dirname -- "$(echo "$(fdup -g "pyproject.toml" -t f)")")" --full-path --color never -E /proc -HI -a -L',
            on_telescope_result_callback = shorter_name
        },
        -- Find venv upper project dir - may be useful, but took much time
        -- fd_up_dot_venv = {
        --     command = 'source $SHELL_FUNC_PATH; $FD /bin/python$ $(dirname -- $(readlink -f "$(echo "$(fdup -g ".venv" -t d)")/..")) --full-path --color never -E /proc -HI -a -L',
        --     on_telescope_result_callback = shorter_name
        -- },
        -- fd_up_venv = {
        --     command = 'source $SHELL_FUNC_PATH; $FD /bin/python$ $(dirname -- $(readlink -f "$(echo "$(fdup -g "venv" -t d)")/..")) --full-path --color never -E /proc -HI -a -L',
        --     on_telescope_result_callback = shorter_name
        -- }
    }
}

vim.api.nvim_set_keymap("n", "<leader>vs", "<cmd>VenvSelect<CR>", opts)
