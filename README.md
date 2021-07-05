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
$ npm install --save-dev --save-exact -g prettier
```

Install [Lazygit](https://github.com/jesseduffield/lazygit#installation) - a simple terminal UI for git commands.

Install [Lazydocker](https://github.com/jesseduffield/lazydocker#installation) - a simple terminal UI for both docker and docker-compose.

Install [ripgrep](https://github.com/BurntSushi/ripgrep#installation) - fast search tool.

Install [FZF](https://github.com/junegunn/fzf) - command-line fuzzy finder.

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

Keys | Action | Mode | Installation
---|---|---|---
**F8** | Toggle Tagbar | Normal | Neovim IDE
**Ctrl+n** | Toggle NerdTree | Normal | Neovim IDE
**Ctrl+n** | Toggle Deoplete completion | Insert | Neovim IDE
**Ctrl+p** | Toggle CtrlP | Normal | Vim
**Ctrl+i** | Toggle indent lines | Normal | ALL
**Ctrl+h** | Toggle hidden symbols | Normal | ALL
**Ctrl+Arrows** | Resize splits | Normal | ALL
**Ctrl+m** or **Enter** | Maximize split | Normal | ALL
**Ctrl+m** **,** | Set split sizes equal | Normal | ALL
[**number**] + **n** / **N** | Insert blank line below/above cursor | Normal | ALL
**leader+d[d]** | delete without yanking | Normal/Visual | ALL
**leader+p** | paste without yanking | Normal/Visual | ALL
**cp** | Copy to system buffer | Visual | ALL
**cv** | Paste from system buffer | Normal | ALL
**gcc / gc** | Comment line / selected text | Normal/Visual | ALL
**Ctrl+q / l** | Toggle quickfix/location list | Normal | Neovim IDE
**Enter** in quickfix/location list | Open usage in previous buffer | Normal | Neovim IDE
**Ctrl+v / x / t** in quickfix/location list | Open usage v: vertical split, x: horizontal split, t: tab | Normal | Neovim IDE
**leader+ESC** in terminal | Exit from terminal insert mode | Insert | ALL
**leader+t** | Open Floaterm (project root) | Normal | Neovim IDE
**leader+\`** | Open horizontal terminal (file parent dir) | Normal | ALL
**leader+\`1** | Open vertical terminal (file parent dir) | Normal | ALL
**leader+g** | Open Lazygit in vertical split | Normal | Neovim IDE
**leader+gf**  | Open Lazygit maximized | Normal | Neovim IDE
**leader+c** | Open Lazydocker in vertical split | Normal | Neovim IDE
**leader+cf**  | Open Lazydocker maximized | Normal | Neovim IDE
**ghp**  | Preview git hunk | Normal | Neovim IDE
**leader+m** | Open markdown preview in browser | Normal | Neovim IDE
**leader+f** | Format code | Normal | Neovim IDE
**leader+q** | Quick quit (:q) | Normal | ALL
**leader+q1** | Quick quit without saving (:q!) | Normal | ALL
**leader+qa** | Quit all without saving (:qa!) | Normal | ALL
**leader+w** | Quick save (:w) | Normal | ALL
**ff** | Fuzzy find files. Respect ignore files | Normal | Neovim IDE
**F** | Fuzzy find all files. | Normal | Neovim IDE
**fa** | Find text in all project files | Normal | Neovim IDE
**fb** | Find text in opened buffers | Normal | Neovim IDE
**ca** | Find word under cursor in all project files | Normal | Neovim IDE
**cb** | Find word under cursor in opened buffers | Normal | Neovim IDE
**fr** | Replace occurrences in quickfix list | Normal | Neovim IDE
**leader+s** | Insert docstring | Normal | Neovim IDE
**Ctrl+s** | Insert snippet | Normal | Neovim IDE
**Ctrl+l** | List snippets | Normal | Neovim IDE

**Python IDE**

Keys | Action | Mode | Installation
---|---|---|---
**leader+j** | Go to assignments | Normal | Neovim IDE
**leader+jj** | Go to definition | Normal | Neovim IDE
**leader+n** | Find usages | Normal | Neovim IDE
**leader+r** | Rename | Normal | Neovim IDE
**K** | Show docstring | Normal | Neovim IDE
--- | **Debug** | --- | ---
**F5** | Run debug | Normal | Neovim IDE
**F2** | Step over | Normal | Neovim IDE
**F3** | Step into | Normal | Neovim IDE
**F4** | Step out | Normal | Neovim IDE
**F9** | Run to cursor | Normal | Neovim IDE
**F10** | Set breakpoint | Normal | Neovim IDE
**F11** | Get context | Normal | Neovim IDE
**leader+c** | Eval under cursor | Normal | Neovim IDE
**leader+v** | Eval visual | Normal | Neovim IDE
**x** | Detach | Normal | Neovim IDE
**q** | Close | Normal | Neovim IDE

Debugging workflow:
1. Set breakpoints or use Run to cursor (\<F9\>)
2. Run debugger - \<F5\>
3. Run target script: `pydbgp myscript.py`
4. Navigate over breakpoints \<F2\> \<F3\> \<F4\> or use \<F9\>

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
