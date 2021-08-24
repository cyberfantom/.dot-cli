# .dot-cli

This environment has been made mostly for myself for every day work in the Linux command line. Contains pre-configured VIM/Neovim and Tmux.
Vim exists here in two states:
- **Vim Regular**.
    Running with regular command `vim` and using a default file `~/.vimrc`. Useful for fast text edit or deploy to remote servers with minimal requirements.
- **Neovim IDE**. IDE-like setup (for now only Python).
    Running with command `nvim` and using a default file `~/.config/nvim/init.vim`. Contains same setup as Vim Regular + linters, code formaters, autocomplete, etc.

Also here is a file `.ideavimrc` for IdeaVim emulation plugin for IntelliJ Platform-based IDEs. The goal is sharing the same key bindings (as possible) in both Vim and IntelliJ IDEs.

### Requirements
- Vim 8.x / Neovim 0.5.x
- Tmux >= 2.6
- Git
- Python3 and pip
- Powerline-compatible font

### Installation

**Note, that installation script will erase your existing Vim/Neovim and Tmux configuration! Save them before installation, if needed.**

#### Notes before install

Depends of what do you want to install, here can be a various options. Default setup (`install.sh` without parameters) is a Vim Regular setup + Tmux. Note, that installation script only deploying configuration and installing plugins plus python packages.

**Tmux** configuration requires **Tmux >= 2.6**. If you don't have it in your package manager, follow [Install required packages](#install-required-packages),
 then [Build latest Tmux from source](#build-latest-tmux-from-source).

**Vim Regular** requires only **Vim 8.x+** with Python support, so you can use (mostly) Vim from your system package manager and just follow [Install .dot-cli environment](#install-.dot-cli-environment)

**Neovim IDE** requires **Neovim 0.5.x+** with LSP. If you don't have it in your package manager, follow [Install required packages](#install-required-packages),
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
$ sudo make CMAKE_BUILD_TYPE=Release CMAKE_INSTALL_PREFIX=/usr/local/stow/nvim install

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
$ npm install -g pyright # python language server
$ npm install --save-dev --save-exact -g prettier
```

Install [Lazygit](https://github.com/jesseduffield/lazygit#installation) - a simple terminal UI for git commands.

Install [Lazydocker](https://github.com/jesseduffield/lazydocker#installation) - a simple terminal UI for both docker and docker-compose.

Install [ripgrep](https://github.com/BurntSushi/ripgrep#installation) - fast search tool.

Install [FZF](https://github.com/junegunn/fzf) - command-line fuzzy finder.

Install [Kitty](https://sw.kovidgoyal.net/kitty/binary/) - The fast, feature-rich, GPU based terminal emulator.
Kitty configuration included in this repo.

Install [NerdFonts](https://github.com/ryanoasis/nerd-fonts) - Powerline compatible fonts.

#### Build latest Tmux from source

**DEB-based distros**
```bash
$ sudo apt install build-essential checkinstall \
libevent-dev ncurses-dev libutf8proc-dev libutempter-dev bison pkg-config
```

**RPM-based distros**

```bash
$ sudo yum group install "Development Tools"
$ sudo yum install checkinstall libevent-devel ncurses-devel utf8proc-devel libutempter-devel bison pkg-config
```

```bash
# get latest version of Tmux: https://github.com/tmux/tmux/tags
# and set in script below: TMUX_TAG="<TAG>"
# optionally use configure options --enable-utempter --enable-utf8proc
$ TMUX_TAG="3.2"
$ cd /tmp && \
git clone https://github.com/tmux/tmux.git && \
cd tmux && \
git checkout tags/$TMUX_TAG && \
sh autogen.sh && \
./configure && make -j $(nproc --all) && \
sudo checkinstall --pkgname tmux --pkgversion $TMUX_TAG

# Uninstall Tmux instalaltion with package manager, if needed
dpkg -r tmux # deb-based
rpm -e tmux # rpm-based
```

#### Install .dot-cli environment

- `install.sh` without options - install just **Vim Regular** + **Tmux**
- `--neovim` option installs **Vim Regular** + **Tmux** + **Neovim IDE**
- `--kitty` option installs **Kitty** terminal config to `~/.config/kitty/`

```bash
$ git clone https://github.com/cyberfantom/.dot-cli.git ~/.dot-cli && cd ~/
$ .dot-cli/install.sh [--neovim] [--kitty]
```
Next, just login again or run:
```bash
$ . ~/.bashrc
```

### Usage

Now we have installed Vim/Neovim and Tmux. Use as usual. Change as you want.

### Features and Hot keys

#### Vim / Neovim

**Extra keys**

Keys | Action | Mode | Installation
---|---|---|---
**Ctrl+p** | Toggle CtrlP | Normal | Vim
**Ctrl+i** | Toggle indent lines | Normal | ALL
**Ctrl+h** | Toggle hidden symbols | Normal | ALL
**Ctrl+Arrows** | Resize splits | Normal | ALL
[**number**] + **n** / **N** | Insert blank line below/above cursor | Normal | ALL
**leader+d[d]** | delete without yanking | Normal/Visual | ALL
**leader+p** | paste without yanking | Normal/Visual | ALL
**cp** | Copy to system buffer | Visual | ALL
**cv** | Paste from system buffer | Normal | ALL
**gcc / gc** | Comment line / selected text | Normal/Visual | ALL
**leader+ESC** in terminal | Exit from terminal insert mode | Insert | ALL
**leader+\`** | Open horizontal terminal (file parent dir) | Normal | ALL
**leader+\`1** | Open vertical terminal (file parent dir) | Normal | ALL
**leader+q** | Quick quit (:q) | Normal | ALL
**leader+q1** | Quick quit without saving (:q!) | Normal | ALL
**leader+qa** | Quit all without saving (:qa!) | Normal | ALL
**leader+w** | Quick save (:w) | Normal | ALL
**leader+u** | Toggle UndoTree | Normal | ALL

**Neovim IDE keys**

Keys | Action | Mode
---|---|---
**Ctrl+n** | Toggle files tree | Normal
**Enter** in quickfix/location list | Open usage in previous buffer | Normal
**Ctrl+v / x / t** in quickfix/location list | Open usage v: vertical split, x: horizontal split, t: tab | Normal
**leader+t** | Open Floaterm (project root) | Normal
**leader+g** | Open Lazygit in vertical split | Normal
**leader+gf**  | Open Lazygit maximized | Normal
**leader+c** | Open Lazydocker in vertical split | Normal
**leader+cf**  | Open Lazydocker maximized | Normal
**leader+m** | Open markdown preview in browser | Normal
**Ctrl+q** in Telescope | Selection to quickfix list | Normal
**ff** | Telescope fuzzy find files. | Normal
**fg** | Telescope live grep. | Normal
**fb** | Telescope buffers. | Normal
**fh** | Telescope help tags. | Normal
**fe** | Telescope file browser. | Normal
**fd** | Telescope LSP diagnostics. | Normal
**fl** | Telescope list of all builtins. | Normal
**fa** | Ferret text in all project files | Normal
**ca** | Ferret word under cursor in all project files | Normal
**cb** | Ferret word under cursor in opened buffers | Normal
**fr** | Replace occurrences in quickfix list | Normal

**Neovim IDE code navigation and actions**

Keys | Action | Mode
---|---|---
**F8** | Toggle Tagbar | Normal
**leader+s** | Insert docstring | Normal
**leader+f** | Format code | Normal
**Ctrl+n** | Toggle autocompletion | Insert
**gj** | Go to declaration | Normal
**gd** | Go to definition (opens in tab) | Normal
**gi** | Go to implementation | Normal
**gu** | Find usages (quickfix list) | Normal
**ge** | Show line diafnostics | Normal
**gp** | Show definition preview | Normal
**gr** | Rename under cursor. **Enter** - execute, **q** - quit | Normal
**gs** | Show signature help | Normal
**K** | Show docstring | Normal
**leader-ca** | Code action. **Enter** - execute, **q** - quit | Normal / Visual
**space-wa** | Add workspace folder | Normal
**space-wr** | Remove workspace folder | Normal
**space-wl** | List workspace folders | Normal
**Ctrl-f / Ctrl-u** | Scroll over items in most cases | Normal


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
**prefix** + **Ctrl-s**/**Ctrl-r** | Save/restore session (tmux-resurrect plugin defaults)
