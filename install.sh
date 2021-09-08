#!/bin/bash

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
NEOVIM=0
KITTY=0
STARSHIP=0

for arg in "$@"
do
    case $arg in
        --neovim)
        NEOVIM=1
        shift
        ;;
        --kitty)
        KITTY=1
        shift
        ;;
        --starship)
        STARSHIP=1
        shift
        ;;
    esac
done

# Add string to file if not exists
function update_file() {
    # $1 - string
    # $2 - file
    if ! grep -Fxq "$1" "$2"
    then
        echo $1 >> $2
    fi
}

# Install Starship
if [ ${STARSHIP} -eq 1 ]; then
    update_file 'eval "$(starship init bash)"' ~/.bashrc
    cp "${SCRIPT_PATH}/starship/starship.toml" ~/.config/starship.toml
fi

# Install neovim requirements
if [ ${NEOVIM} -eq 1 ]; then
   pip3 install --user --upgrade -r ${SCRIPT_PATH}/vim/requirements.nvim.txt;
fi

# Clean previous Vim installation and install Vundle + Vim-plug
# @TODO: remove Vundle
rm -rf ~/.vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
if [ ${NEOVIM} -eq 1 ]; then
    rm -rf ~/.config/nvim && mkdir -p ~/.config/nvim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# Setup configuration files
echo "source ${SCRIPT_PATH}/vim/.vimrc" > ~/.vimrc
echo "source ${SCRIPT_PATH}/vim/init.vim" > ~/.config/nvim/init.vim

# Install plugins
vim -c ":PluginInstall" -c ":bdelete" -c ":qa!"
if [ ${NEOVIM} -eq 1 ]; then
   nvim -u ~/.dot-cli/vim/init-plugins.vim -c ":PlugInstall" -c ":bdelete" -c ":qa!"
fi

# Clean previous Tmux installation and install TPM
rm -rf ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf "${SCRIPT_PATH}/tmux/.tmux.conf" ~/.tmux.conf
ln -sf "${SCRIPT_PATH}/tmux/.tmux.remote.conf" ~/.tmux/.tmux.remote.conf
`which tmux` source ~/.tmux.conf && ~/.tmux/plugins/tpm/scripts/install_plugins.sh

# Path and Term environment
update_file 'export PATH=$PATH:$HOME/.local/bin' ~/.bashrc
update_file 'export TERM=xterm-256color' ~/.bashrc

# Misc
update_file 'alias mc="mc -S xoria256.ini"' ~/.bashrc
update_file 'alias ssh="TERM=xterm-256color ssh"' ~/.bashrc

## kitty config
if [ ${KITTY} -eq 1 ]; then
    mkdir -p ~/.config/kitty/
    cp -R ${SCRIPT_PATH}/kitty/* ~/.config/kitty/
fi

# Reload daemons and configs
`which tmux` kill-server
rm -rf /tmp/tmux-${UID}/
source ~/.bashrc

exit 0
