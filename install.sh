#!/bin/bash

SCRIPT_PATH="$(
    cd "$(dirname "$0")"
    pwd -P
)"
NEOVIM=0
TMUX=0

for arg in "$@"; do
    case $arg in
        --neovim)
            NEOVIM=1
            shift
            ;;
        --tmux)
            TMUX=1
            shift
            ;;
    esac
done

# Add string to file if not exists
function update_file() {
    # $1 - string
    # $2 - file
    if ! grep -Fxq "$1" "$2"; then
        echo "$1" >> "$2"
    fi
}

# Install neovim requirements
if [ ${NEOVIM} -eq 1 ]; then
    pip3 install --user --upgrade -r "${SCRIPT_PATH}/vim/requirements.nvim.txt"
fi

# Clean previous Vim installation and install Vim-plug
rm -rf ~/.vim
curl -fLo ~/.vim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
if [ ${NEOVIM} -eq 1 ]; then
    rm -rf ~/.config/nvim && mkdir -p ~/.config/nvim
    nvim_data_dir="${XDG_DATA_HOME:-$HOME/.local/share}/nvim"
    rm -rf "$nvim_data_dir" && mkdir -p "$nvim_data_dir"
fi

# Setup configuration files
echo "source ${SCRIPT_PATH}/vim/.vimrc" > ~/.vimrc
if [ ${NEOVIM} -eq 1 ]; then
    echo "dofile('${SCRIPT_PATH}/vim/init.lua')" > ~/.config/nvim/init.lua
fi

# Install Vim plugins
vim +PlugInstall! +qa!

# Clean previous Tmux installation and install TPM
if [ ${TMUX} -eq 1 ]; then
    rm -rf ~/.tmux
    git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
    ln -sf "${SCRIPT_PATH}/tmux/.tmux.conf" ~/.tmux.conf
    ln -sf "${SCRIPT_PATH}/tmux/.tmux.remote.conf" ~/.tmux/.tmux.remote.conf
    $(which tmux) source ~/.tmux.conf && ~/.tmux/plugins/tpm/scripts/install_plugins.sh
fi

# Path and Term environment
update_file 'export PATH=$PATH:$HOME/.local/bin' ~/.bashrc
update_file 'export TERM=xterm-256color' ~/.bashrc

# Shell functions
update_file 'source '"${SCRIPT_PATH}"'/shell/functions' ~/.bashrc

# Reload daemons and configs
if [ ${TMUX} -eq 1 ]; then
    $(which tmux) kill-server
    rm -rf /tmp/tmux-${UID}/
fi
source ~/.bashrc
echo -e "\nINSTALLATION COMPLETE"

exit 0
