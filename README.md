# .dot-cli

This environment has been made mostly for myself for every day work in the Linux command line. Contains pre-configured VIM/Neovim and Tmux.
Vim exists here in two states:
- **Vim Regular**.
    Running with regular command `vim` and using a default file `~/.vimrc`. Useful for fast text edit or deploy to remote servers with minimal requirements.
- **Neovim IDE**. IDE-like setup (for now only Python).
    Running with command `nvim` and using a default file `~/.config/nvim/init.vim`. Contains same setup as Vim Regular + linters, code formaters, autocomplete, etc.

Also here is a file `.ideavimrc` for IdeaVim emulation plugin for IntelliJ Platform-based IDEs. The goal is sharing the same key bindings (as possible) in both Vim and IntelliJ IDEs.

### Requirements
- Vim 8.x / Neovim 4.x
- Tmux 3
- Git
- Python3 and pip
- Powerline-compatible font

### Installation

**Note, that installation script will erase your existing Vim/Neovim and Tmux configuration! Save them before installation, if needed.**

#### Notes before install

Depends of what do you want to install, here can be a various options. Default setup (`install.sh` without parameters) is a Vim Regular setup + Tmux. Note, that installation script only deploying configuration and installing plugins plus python packages.

**Tmux** configuration requires **Tmux 3**. If you don't have it in your package manager, follow [Install required packages](#install-required-packages),
 then [Build latest Tmux from source](#build-latest-tmux-from-source).

**Vim Regular** requires only **Vim 8.x+** with Python support, so you can use (mostly) Vim from your system package manager and just follow [Install .dot-cli environment](#install-.dot-cli-environment)

**Neovim IDE** requires **Neovim 4.x+** with Python support. If you don't have it in your package manager, follow [Install required packages](#install-required-packages),
 then [Build latest Neovim from source and install for current user](#build-latest-neovim-from-source-and-install-for-current-user).
Also, **Neovim IDE** requires a tools from section [Install recommended tools](#install-recommended-tools).

When you will have installed a right versions of **Tmux** and **Vim/Neovim** , just follow [Install .dot-cli environment](#install-.dot-cli-environment)

#### Install required packages

**DEB-based distros**
```bash
$ sudo apt install git curl python3-pip xsel
# Neovim setup required packages
$ sudo apt install mc shellcheck tidy jq
```

**RPM-based distros**
```bash
$ sudo yum install epel-release
# check for the latest available python version
$ sudo yum install python36-pip
$ sudo yum install git curl xsel
# Neovim setup required packages
$ sudo yum install mc ShellCheck tidy jq
```

#### Build latest Neovim from source and install for current user

**DEB-based distros**
```bash
$ sudo apt install build-essential python3-dev stow
```

**RPM-based distros**
```bash
$ sudo yum group install "Development Tools"
$ sudo yum install python3-devel stow
```

Install required packages from [Neovim Build prerequisites](https://github.com/neovim/neovim/wiki/Building-Neovim#build-prerequisites)

```bash
$ cd /tmp
$ git clone https://github.com/neovim/neovim.git
$ cd neovim
$ git checkout stable
$ make CMAKE_BUILD_TYPE=Release -j $(nproc --all)
$ sudo make CMAKE_INSTALL_PREFIX=/usr/local/stow/nvim install

# Install Neovim for current user
$ stow -d /usr/local/stow -t ~/.local nvim

# check
$ . ~/.bashrc && nvim --version

# Uninstall Neovim installation, if needed:
$ stow -d /usr/local/stow -t ~/.local -D nvim && \
sudo rm -rf /usr/local/stow/nvim
```

#### Install recommended tools

The followed tools are optional, but recommended if you want to use all Neovim IDE features.

Universal Ctags:
```bash
# More info here: https://github.com/universal-ctags/ctags/blob/master/docs/autotools.rst
$ cd /tmp && git clone https://github.com/universal-ctags/ctags.git && \
cd ctags && \
./autogen.sh && \
./configure && \
make && \
sudo checkinstall --pkgname ctags
```

shfmt, a shell scripts format tool:
```bash
# Check latest release and platform here: https://github.com/mvdan/sh/releases
$ sudo curl -L https://github.com/mvdan/sh/releases/download/v3.2.4/shfmt_v3.2.4_linux_amd64 \
-o /usr/local/bin/shfmt && \
sudo chmod +x /usr/local/bin/shfmt
```

Some Neovim plugins requires Node with a few packages. If you don't have installed Node, just install with NVM:
```bash
# check latest NVM version
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.38.0/install.sh | bash
$ source ~/.profile && source ~/.bashrc
$ nvm install --lts --latest-npm

# Get help, uninstall, upgrade
nvm --help
nvm uninstall --lts
nvm install --lts --latest-npm --reinstall-packages-from='lts/*'
```

Install required npm packages:
```bash
# Install npm packages
$ npm install -g yarn
$ npm install -g neovim
$ npm install --save-dev --save-exact -g prettier
```

Install [Lazygit](https://github.com/jesseduffield/lazygit#installation) - a simple terminal UI for git commands.

#### Build latest Tmux from source

**DEB-based distros**
```bash
$ sudo apt install build-essential checkinstall \
libevent-dev libutf8proc-dev libutempter-dev bison pkg-config
```

**RPM-based distros**

```bash
$ sudo yum group install "Development Tools"
$ sudo yum install checkinstall libevent-devel utf8proc-devel libutempter-devel bison pkg-config
```

```bash
# get latest version of Tmux: https://github.com/tmux/tmux/tags
# and set in script below: TMUX_TAG="<TAG>"
$ TMUX_TAG="3.1c"
$ cd /tmp && \
git clone https://github.com/tmux/tmux.git && \
cd tmux && \
git checkout tags/$TMUX_TAG && \
sh autogen.sh && \
./configure --enable-utempter --enable-utf8proc && make && \
sudo checkinstall --pkgname tmux --pkgversion $TMUX_TAG

# Uninstall Tmux instalaltion with package manager, if needed
dpkg -r tmux # deb-based
rpm -e tmux # rpm-based
```

#### Install .dot-cli environment

- `install.sh` without options - install just **Vim Regular** + **Tmux**
- `install.sh --neovim` - install **Vim Regular** + **Tmux** + **Neovim IDE**

```bash
$ git clone https://github.com/cyberfantom/.dot-cli.git ~/.dot-cli && cd ~/
$ .dot-cli/install.sh [--neovim]
```
Next, just login again or run:
```bash
$ . ~/.bashrc
```

### Usage

Now we have installed Vim/Neovim and Tmux. Use as usual. Change as you want.

### Features and Hot keys

#### VIM

**Extra Keys**

Keys | Action | Installation
---|---|---
**F8** | Toggle Tagbar | Neovim IDE
**Ctrl+n** | Toggle NerdTree | Neovim IDE
**Ctrl+p** | Toggle CtrlP | ALL
**Ctrl+i** in normal mode | Toggle indent lines | ALL
**Ctrl+h** in normal mode | Toggle hidden symbols | ALL
**Ctrl+Arrows** in normal mode | Resize splits | ALL
**Ctrl+m** or **Enter** in normal mode | Maximize split | ALL
**Ctrl+m** **,** in normal mode | Set split sizes equal | ALL
[**number**] + **n** / **N** in normal mode | Insert blank line below/above cursor | ALL
**leader+d[d]** in any mode | delete without yanking | ALL
**leader+p** in any mode | paste without yanking | ALL
**cp** in visual mode | Copy to system buffer | ALL
**cv** in any mode | Paste from system buffer | ALL
**gcc / gc** in any mode | Comment line / selected text | ALL
**leader-e** in any mode | Open errors buffer | ALL
**Enter** in "errors buffer" | Jump to error | ALL
**leader-ESC** in terminal | Exit from terminal insert mode | ALL
**leader-t** in any mode | Open Floaterm (project root) | Neovim IDE
**leader-\`** in any mode | Open horizontal terminal (file parent dir) | ALL
**leader-\`1** in any mode | Open vertical terminal (file parent dir) | ALL
**leader-g** in normal mode | Open Lazygit in vertical split | Neovim IDE
**leader-gf** in normal mode | Open Lazygit maximized | Neovim IDE
**leader-m** in normal mode | Open markdown preview in browser | Neovim IDE
**leader-f** in normal mode | Format code | Neovim IDE
**leader-q** in normal mode | Quick quit (:q) | ALL
**leader-q1** in normal mode | Quick quit without saving (:q!) | ALL
**leader-qa** in normal mode | Quit all without saving (:qa!) | ALL
**leader-w** in normal mode | Quick save (:w) | ALL

#### Tmux

Nested sessions - this config allows you to run remote Tmux session in the local one with switching local/remote keymap by keys **Ctrl** + **Space**.

**Extra Keys**

Default prefix **Ctrl + b**.

Keys | Action
---|---
**Ctrl** + **Space** | Toggle on/off all keybindings for local or remote session
**v** in copy mode | Vim-style text selection
**y** in copy mode | Vim-style selected text copy to buffers (Tmux + system)
**prefix** + **r** | Reload Tmux config
**prefix** + **@** | Join pane to selected window
**prefix** + **Tab**/**Backspace** | Toggle tree directory listing in sidebar (tmux-sidebar plugin defaults)
**prefix** + **Ctrl-s**/**Ctrl-r** | Save/restore session (tmux-resurrect plugin defaults)
