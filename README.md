# .dot-cli
 Simple environment for comfortable work in the Linux command line. All key-bindings are default. Optimal minimum of plugins.

### Requirements
- Vim
- Tmux
- Git
- Python3 and pip

### Installation
Note, that installation script will erase your existing vim and tmux configuration.
Also note, that installation script only deploing configuration. You should install required packages before running the installer, see the requirements section above.

**Example packages installation for rpm-based distros**
```bash
$ sudo yum install epel-release
# check for the latest available python version
$ sudo yum install python34-pip
$ sudo yum install vim tmux git
```

**Example packages installation for deb-based distros**
```bash
$ sudo apt install vim tmux git python3-pip
```

**Run installer**
```bash
$ git clone https://github.com/cyberfantom/.dot-cli.git ~/.dot-cli && cd ~/
$ bash .dot-cli/install.sh
```

### Usage
Use as usual. Change as you want.
