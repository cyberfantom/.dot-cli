#!/bin/bash

SCRIPT_PATH="$( cd "$(dirname "$0")" ; pwd -P )"
NEOVIM=0

for arg in "$@"
do
    case $arg in
        --neovim)
        NEOVIM=1
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

# Install packages
pip3 install --user --upgrade powerline-status
if [ ${NEOVIM} -eq 1 ]; then
   pip3 install --user --upgrade -r ${SCRIPT_PATH}/requirements.nvim.txt;
fi

# Clean previous Vim installation and install Vundle + Vim-plug
rm -rf ~/.vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
if [ ${NEOVIM} -eq 1 ]; then
    rm -rf ~/.config/nvim && mkdir -p ~/.config/nvim
    sh -c 'curl -fLo "${XDG_DATA_HOME:-$HOME/.local/share}"/nvim/site/autoload/plug.vim --create-dirs \
       https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
fi

# Setup configuration files
echo "source ${SCRIPT_PATH}/.vimrc" > ~/.vimrc
echo "source ${SCRIPT_PATH}/init.vim" > ~/.config/nvim/init.vim

# Install plugins
vim -c ":PluginInstall" -c ":bdelete" -c ":q!"
if [ ${NEOVIM} -eq 1 ]; then
   nvim -c ":PlugInstall" -c ":bdelete" -c ":q!"
fi

# Clean previous Tmux installation and install TPM
rm -rf ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf "${SCRIPT_PATH}/.tmux.conf" ~/.tmux.conf
ln -sf "${SCRIPT_PATH}/.tmux.remote.conf" ~/.tmux/.tmux.remote.conf
`which tmux` source ~/.tmux.conf && ~/.tmux/plugins/tpm/scripts/install_plugins.sh

# Path and Term environment
update_file 'export PATH=$PATH:$HOME/.local/bin' ~/.bashrc
update_file 'export TERM=xterm-256color' ~/.bashrc

# Install powerline
PY3_LOCAL_VER=`python3 -c 'import sys; print(str(sys.version_info[0])+"."+str(sys.version_info[1]))'`
POWERLINE_PATH="~/.local/lib/python${PY3_LOCAL_VER}/site-packages/powerline"

P_LINE="$(cat <<-END
if [ -f ${POWERLINE_PATH}/bindings/bash/powerline.sh ]; then
    powerline-daemon -q;
    POWERLINE_BASH_CONTINUATION=1;
    POWERLINE_BASH_SELECT=1;
    . ${POWERLINE_PATH}/bindings/bash/powerline.sh;
fi
END
)"
P_LINE="$(echo ${P_LINE})"
update_file "${P_LINE}" ~/.bashrc

# set tmux powerline config
echo "source ${POWERLINE_PATH}/bindings/tmux/powerline.conf" > ~/.tmux/.tmux.powerline.conf

# powerline configs
eval POWERLINE_PATH=$POWERLINE_PATH
mkdir -p ~/.config/powerline
cp -R ${POWERLINE_PATH}/config_files/* ~/.config/powerline/
cp -R ${SCRIPT_PATH}/powerline/* ~/.config/powerline/

# Misc
update_file 'alias mc="mc -S xoria256.ini"' ~/.bashrc

# Reload daemons and configs
$HOME/.local/bin/powerline-daemon --kill
`which tmux` kill-server
source ~/.bashrc

exit 0
