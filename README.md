# .dot-cli

This environment has been made mostly for myself for every day work in the Linux command line. Contains pre-configured VIM/Neovim and Tmux.
Vim exists here in two states:

- **Vim Regular**.
  Running with regular command `vim` and using a default file `~/.vimrc`. Useful for fast text edit or deploy to remote servers with minimal requirements.
- **Neovim IDE**. IDE-like setup for Python, Go, Typescript and Rust.
  Running with command `nvim` and using a default file `~/.config/nvim/init.vim`. Contains same setup as Vim Regular + linters, code formaters, autocomplete, etc.

Also here is a file `.ideavimrc` for IdeaVim emulation plugin for IntelliJ Platform-based IDEs. The goal is sharing the same key bindings (as possible) in both Vim and IntelliJ IDEs.

## Requirements

- Vim 8.x / Neovim 0.6.x
- Tmux >= 2.6
- Node.js (for Neovim IDE)
- Git
- Python3 and pip
- Powerline-compatible font

## Installation

**Note, that installation script will erase your existing Vim/Neovim and Tmux configuration! Save them before installation, if needed.**

Follow [Installation instructions](INSTALL.md).

## Usage

Extra usage information you can find in [Notes](NOTES.md).

### Common Vim / Neovim

| Keys                                       | Action                                        | Mode          | Installation |
| ------------------------------------------ | --------------------------------------------- | ------------- | ------------ |
| **Ctrl+p**                                 | Toggle CtrlP                                  | Normal        | Vim          |
| **F3**                                     | Toggle maximized/minimized window view        | Normal        | ALL          |
| **Ctrl+i**                                 | Toggle indent lines                           | Normal        | ALL          |
| **Ctrl+h**                                 | Toggle hidden symbols                         | Normal        | ALL          |
| **leader+/**                               | Toggle diff mode for splits in current window | Normal        | ALL          |
| **Ctrl+Arrows**                            | Resize splits                                 | Normal        | ALL          |
| [**number**] + **n** / **N**               | Insert blank line below/above cursor          | Normal        | ALL          |
| **leader+d[d]**                            | delete without yanking                        | Normal/Visual | ALL          |
| **leader+p**                               | paste without yanking                         | Normal/Visual | ALL          |
| **cp**                                     | Copy to system buffer                         | Visual        | ALL          |
| **cv**                                     | Paste from system buffer                      | Normal        | ALL          |
| **gcc / gc**                               | Comment line / selected text                  | Normal/Visual | ALL          |
| **leader+ESC** in terminal                 | Exit from terminal insert mode                | Insert        | ALL          |
| **leader+\`**                              | Open horizontal terminal (file parent dir)    | Normal        | ALL          |
| **leader+\`1**                             | Open vertical terminal (file parent dir)      | Normal        | ALL          |
| **leader+q**                               | Quick quit (:q)                               | Normal        | ALL          |
| **leader+q1**                              | Quick quit without saving (:q!)               | Normal        | ALL          |
| **leader+qa**                              | Quit all without saving (:qa!)                | Normal        | ALL          |
| **leader+w**                               | Quick save (:w)                               | Normal        | ALL          |
| **leader+x**                               | Toggle quickfix list                          | Normal        | ALL          |
| **leader+u**                               | Toggle UndoTree                               | Normal        | ALL          |
| **Shift-Up**, **Ctrl-f** or **PageUp**     | Scroll one screen up                          | Normal        | ALL          |
| **Shift-Down**, **Ctrl-b** or **PageDown** | Scroll one screen down                        | Normal        | ALL          |
| **Ctrl-u** / **Ctrl-d**                    | Scroll half screen up / down                  | Normal        | ALL          |

### Neovim IDE keys

| Keys                                                         | Action                                                                                                   | Mode          |
| ------------------------------------------------------------ | -------------------------------------------------------------------------------------------------------- | ------------- |
| **Ctrl+n**                                                   | Toggle files tree                                                                                        | Normal        |
| **Enter** in quickfix/location list                          | Open usage in previous buffer                                                                            | Normal        |
| **Ctrl+v / x / t** in quickfix/location/Files tree/Telescope | Open in v: vertical split, x: horizontal split, t: tab                                                   | Normal        |
| **leader+t**                                                 | Open Floaterm (project root)                                                                             | Normal        |
| **leader+g**                                                 | Open Lazygit in vertical split                                                                           | Normal        |
| **leader+gf**                                                | Open Lazygit maximized                                                                                   | Normal        |
| **leader+c**                                                 | Open Lazydocker in vertical split                                                                        | Normal        |
| **leader+cf**                                                | Open Lazydocker maximized                                                                                | Normal        |
| **leader+m**                                                 | Open markdown preview in browser                                                                         | Normal        |
| **leader+hi**                                                | Gitsigns diff file against the index                                                                     | Normal        |
| **leader+hl**                                                | Gitsigns diff file against the last commit                                                               | Normal        |
| **leader+hs**                                                | Gitsigns stage hunk                                                                                      | Normal/Visual |
| **leader+hu**                                                | Gitsigns undo stage hunk                                                                                 | Normal        |
| **leader+hr**                                                | Gitsigns reset hunk                                                                                      | Normal/Visual |
| **leader+hR**                                                | Gitsigns reset buffer                                                                                    | Normal        |
| **leader+hp**                                                | Gitsigns preview hunk                                                                                    | Normal        |
| **leader+hb**                                                | Gitsigns blame line                                                                                      | Normal        |
| **leader+hS**                                                | Gitsigns stage buffer                                                                                    | Normal        |
| **leader+hU**                                                | Gitsigns reset buffer index                                                                              | Normal        |
| **Ctrl+q** in Telescope                                      | Selection to quickfix list                                                                               | Normal        |
| **ff**                                                       | Telescope fuzzy find files.                                                                              | Normal        |
| **fa**                                                       | Telescope live grep all project files.                                                                   | Normal        |
| **fb**                                                       | Telescope live grep current buffer.                                                                      | Normal        |
| **ft**                                                       | Telescope file browser.                                                                                  | Normal        |
| **fe**                                                       | Telescope LSP diagnostics.                                                                               | Normal        |
| **fl**                                                       | Telescope list of all builtins.                                                                          | Normal        |
| **fg**                                                       | Telescope current buffer commits. **Ctrl+v/x/t** - opens diff in vertical/horizontal split or tab        | Normal        |
| **ca**                                                       | Telescope word under cursor in all project files                                                         | Normal        |
| **cb**                                                       | Telescope word under cursor in opened buffers                                                            | Normal        |
| **fr**                                                       | Replace occurrences in quickfix list with `:cfdo` and native search/replace: `%s/search/replace/g`       | Normal        |
| **cr**                                                       | Replace word under cursor in quickfix list with `:cfdo` and native search/replace: `%s/search/replace/g` | Normal        |

### Neovim IDE code navigation and actions

| Keys                | Action                                                 | Mode   |
| ------------------- | ------------------------------------------------------ | ------ |
| **F8**              | Toggle Vista bar                                       | Normal |
| **leader+s**        | Insert docstring                                       | Normal |
| **leader+f**        | Format code                                            | Normal |
| **Ctrl+n**          | Toggle autocompletion                                  | Insert |
| **gj**              | Go to declaration                                      | Normal |
| **gd**              | Go to definition (opens in tab)                        | Normal |
| **gi**              | Go to implementation                                   | Normal |
| **gu**              | Find usages (quickfix list)                            | Normal |
| **ge**              | Show line diafnostics                                  | Normal |
| **gr**              | Rename under cursor. **Enter** - execute, **q** - quit | Normal |
| **gs**              | Show signature help                                    | Normal |
| **K**               | Show docstring                                         | Normal |
| **space-t**         | Show type definition                                   | Normal |
| **space-wa**        | Add workspace folder                                   | Normal |
| **space-wr**        | Remove workspace folder                                | Normal |
| **space-wl**        | List workspace folders                                 | Normal |
| **Ctrl-f / Ctrl-u** | Scroll over menu items in most cases                   | Normal |

### Tmux

Nested sessions - this config allows you to run remote Tmux session in the local one with switching local/remote keymap by keys **Ctrl** + **Space**.
Default Tmux prefix is **Ctrl + b**.

| Keys                               | Action                                                    |
| ---------------------------------- | --------------------------------------------------------- |
| **Ctrl** + **Space**               | Toggle on/off all keybindings for local or remote session |
| **v** in copy mode                 | Vim-style text selection                                  |
| **y** in copy mode                 | Vim-style selected text copy to buffers (Tmux + system)   |
| **prefix** + **r**                 | Reload Tmux config                                        |
| **prefix** + **@**                 | Join pane to selected window                              |
| **prefix** + **Ctrl-s**/**Ctrl-r** | Save/restore session (tmux-resurrect plugin defaults)     |
