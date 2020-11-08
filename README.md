# .dot-cli
 Simple environment for comfortable work in the Linux command line. Pre-configured VIM and Tmux. All key-bindings are default, except a few improvements. Optimal minimum of plugins.

### Requirements
- Vim
- Tmux
- Git
- Python3 and pip
- UTF-8 locale
- Powerline-compatible font

### Installation
**Note, that installation script will erase your existing Vim and Tmux configuration.**
Also note, that installation script only deploing configuration. You should install required packages before running the installer, see the requirements section above.

**Example packages installation for rpm-based distros**
```bash
$ sudo yum install epel-release
# check for the latest available python version
$ sudo yum install python34-pip
$ sudo yum install vim tmux git xsel tig
```

**Example packages installation for deb-based distros**
```bash
$ sudo apt install vim tmux git python3-pip xsel tig
```

**Run installer**
```bash
$ git clone https://github.com/cyberfantom/.dot-cli.git ~/.dot-cli && cd ~/
$ .dot-cli/install.sh
```
Next, just login again or run:
```bash
$ . ~/.bashrc
```

### Usage
Use as usual. Change as you want.

### Features and Hot keys

#### VIM

Just a normal VIM with a few improvements and plugins.

**Extra Keys**

Keys | Result
---|---
**F2** | Vertical terminal
**F3** | Horizontal terminal
**Ctrl+n** | Toggle NerdTree
**Ctrl+p** | Toggle CtrlP
**Ctrl+i** in normal mode | Toggle indent lines
**Ctrl+h** in normal mode | Toggle hidden symbols
**Ctrl+Arrows** in normal mode | Resize splits
**Ctrl+m** or **Enter** in normal mode | Maximize split
**Ctrl+m** **,** in normal mode | Set split sizes equal
[**number**] + **n** / **N** in normal mode | Insert blank line below/above cursor
**leader+d** in any mode | delete without yanking
**leader+p** in any mode | paste without yanking
**cp** in visual mode | Copy to system buffer
**cv** in any mode | Paste from system buffer
**leader-q** in normal mode | Quick quit
**leader-q1** in normal mode | Quick quit without saving
**leader-qa** in normal mode | Quit all without saving
**leader-w** in normal mode | Quick save
**leader-g** in normal mode | Launch Tig git manager
**leader-m** | Preview markdown file in split

#### Tmux

Nested sessions - this config allows you to run remote Tmux session in the local one with switching local/remote keymap by keys **Ctrl** + **Space**.

**Extra Keys**

Default prefix **Ctrl + b**.

Keys | Result
---|---
**Ctrl** + **Space** | Toggle on/off all keybindings for local or remote session
**v** in copy mode | Vim-style text selection
**y** in copy mode | Vim-style selected text copy to buffers (Tmux + system)
**prefix** + **r** | Reload Tmux config
**prefix** + **@** | Join pane to selected window
**prefix** + **Tab**/**Backspace** | Toggle tree directory listing in sidebar (tmux-sidebar plugin defaults)
**prefix** + **Ctrl-s**/**Ctrl-r** | Save/restore session (tmux-resurrect plugin defaults)
