#!/bin/sh

# Clean previous Vim installation and install Vundle
rm -rf ~/.vim
git clone https://github.com/gmarik/vundle.git ~/.vim/bundle/vundle
ln -sf "$(pwd)/$(dirname $0)/.vimrc" ~/.vimrc
vim -c ":PluginInstall" -c ":bdelete" -c ":q!"

# Clean previous Tmux installation and install TPM
rm -rf ~/.tmux
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
ln -sf "$(pwd)/$(dirname $0)/.tmux.conf" ~/.tmux.conf
tmux source ~/.tmux.conf && ~/.tmux/plugins/tpm/scripts/install_plugins.sh
