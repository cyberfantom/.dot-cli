# .dot-cli installation

## Notes before install

Depends of what do you want to install, here can be a various options. Default setup (`install.sh` without parameters) is a Vim setup + Shell functions. Note, that installation script only deploying configuration and installing plugins plus python packages.

**Tmux** configuration requires **Tmux >= 2.6**. If you don't have it in your package manager, follow [Install required packages](#install-required-packages),
then [Build latest Tmux from source](#build-latest-tmux-from-source).

**Vim** setup requires only **Vim 8.x+** with Python support, so you can use (mostly) Vim from your system package manager and just follow [Install .dot-cli environment](#install-.dot-cli-environment)

**Neovim IDE** requires **Neovim 0.8.x+** with LSP. If you don't have it in your package manager, follow [Install required packages](#install-required-packages),
then [Build latest Neovim from source and install for current user](#build-latest-neovim-from-source-and-install-for-current-user).

When you will have installed a right versions of **Tmux** and **Vim/Neovim** , just follow [Install .dot-cli environment](#install-.dot-cli-environment)

## Install required packages

- **DEB-based distros**

  ```bash
  $ sudo apt install git curl python3-pip xsel mc jq vim
  # check if required packages are available, otherwise follow the build guide
  $ sudo apt install neovim tmux
  ```

- **RPM-based distros**

  ```bash
  $ sudo yum install epel-release
  # check for the latest available python version
  $ sudo yum install python36-pip
  $ sudo yum install git curl xsel mc jq vim
  # check if required packages are available, otherwise follow the build guide
  $ sudo yum install neovim tmux
  ```

- **Arch Linux**

  ```bash
  sudo pacman -S git curl python-pip xsel mc jq vim neovim tmux
  ```

### Install required tools

To get all features of Neovim IDE, the following tools must be installed.
There are many installation methods depending on the OS, follow tool's installation
instructions.

- [Universal Ctags](https://github.com/universal-ctags/ctags)

- [astyle](https://astyle.sourceforge.net) - A formatter tool for C, C++, C++/CLI, Objective C, C#, and Java.

- [cppcheck](https://github.com/danmar/cppcheck) - C/C++ static analysis tool.

- [Lazygit](https://github.com/jesseduffield/lazygit#installation) - A simple terminal UI for git commands.

- [Lazydocker](https://github.com/jesseduffield/lazydocker#installation) - A simple terminal UI for both docker and docker-compose.

- [ripgrep](https://github.com/BurntSushi/ripgrep#installation) - Fast search tool.

- [FZF](https://github.com/junegunn/fzf) - Command-line fuzzy finder.

In Arch Linux these tools are present in the repositories (standard and AUR) so they can be installed using the package manager:

```bash
sudo pacman -S ctags lazygit ripgrep fzf cppcheck astyle
# AUR packages
yay -S lazydocker
```

Also it will be a good idea to install [NerdFonts](https://github.com/ryanoasis/nerd-fonts) and/or [JetBrains Mono](https://www.jetbrains.com/lp/mono/)- awesome fonts for developers.

```bash
# NerdFonts example
git clone https://github.com/ryanoasis/nerd-fonts.git && cd nerd-fonts

# Install for user
for i in AnonymousPro Inconsolata Iosevka DejaVuSansMono Go-Mono Meslo FiraCode Hack UbuntuMono JetBrainsMono SourceCodePro Monaspace ; do ./install.sh -U "$i" ; done
# Install to global system path
for i in AnonymousPro Inconsolata Iosevka DejaVuSansMono Go-Mono Meslo FiraCode Hack UbuntuMono JetBrainsMono SourceCodePro Monaspace ; do sudo ./install.sh -S "$i" ; done

# Arch Linux Nerd fonts
sudo pacman -S ttf-jetbrains-mono-nerd ttf-hack-nerd ttf-meslo-nerd ttf-firacode-nerd ttf-go-nerd ttf-ubuntu-mono-nerd ttf-inconsolata-nerd ttf-anonymouspro-nerd ttf-iosevka-nerd ttf-dejavu-nerd ttf-sourcecodepro-nerd otf-monaspace-nerd
```

### Node.js and required packages

Neovim IDE requires Node. If you don't have installed Node, just install with [NVM](https://github.com/nvm-sh/nvm):

```bash
# check latest NVM version
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
$ source ~/.profile && source ~/.bashrc
$ nvm install --lts --latest-npm

# Get help, uninstall, upgrade
nvm --help
nvm uninstall --lts
nvm install --lts --latest-npm --reinstall-packages-from='lts/*'
```

Install required npm packages:
**DEPRECATED** Latest stack version using Mason installer, the following commands no needed anymore.

```bash
# Install npm packages
$ npm install -g yarn neovim eslint_d markdownlint-cli yaml-language-server bash-language-server \
vscode-langservers-extracted graphql-language-service-cli vim-language-server
$ npm install -g pyright # python language server
$ npm install -g typescript typescript-language-server # typescript/js language server
$ npm install --save-dev --save-exact -g prettier

# Update npm packages
$ npm install npm@latest -g
$ npm outdated -g --depth=0
$ npm update -g
```

## Install .dot-cli environment

- `install.sh` without options - install default setup: **Vim** + **Shell functions**
- `--neovim` option installs **Neovim IDE**
- `--tmux` option installs **Tmux** config.

```bash
git clone https://github.com/cyberfantom/.dot-cli.git ~/.dot-cli && cd ~/
.dot-cli/install.sh [--neovim] [--tmux]
```

Next, just login again or run:

```bash
. ~/.bashrc
```

---

## Build Guides

### Build latest Neovim from source and install for current user

- **DEB-based distros**

  ```bash
  sudo apt install build-essential python3-dev stow
  ```

- **RPM-based distros**

  ```bash
  sudo yum group install "Development Tools"
  sudo yum install python3-devel stow
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

### Build latest Tmux from source

- **DEB-based distros**

  ```bash
  $ sudo apt install build-essential checkinstall \
  libevent-dev ncurses-dev libutf8proc-dev libutempter-dev bison pkg-config
  ```

- **RPM-based distros**

  ```bash
  sudo yum group install "Development Tools"
  sudo yum install checkinstall libevent-devel ncurses-devel utf8proc-devel libutempter-devel bison pkg-config
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
