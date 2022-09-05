# .dot-cli Usage Notes

## yaml-language-server scheme

To validate/lint a yaml file add to start of that file a string with pattern:

```yaml
# yaml-language-server: $schema=<urlToTheSchema|relativeFilePath|absoluteFilePath}>
```

Example for docker-compose:

```yaml
# yaml-language-server: $schema=https://raw.githubusercontent.com/compose-spec/compose-spec/master/schema/compose-spec.json
```

Example for Kubernetes deployment:

```yaml
# yaml-language-server: $schema=https://kubernetesjsonschema.dev/master-standalone-strict/deployment.json
```

- Common schemes can be found at: https://www.schemastore.org/json/
- Kubernetes schemes can be found at: https://kubernetesjsonschema.dev/ or https://github.com/instrumenta/kubernetes-json-schema/

## Editorconfig

To manage multiple code styles Neovim IDE uses [Editorconfig plugin](https://github.com/editorconfig/editorconfig-vim).
A common `.editorconfig` file that can be used:

```ini
root = true

# Unix-style newlines with a newline ending every file
# Indentation - space, size - 2 for each file
[*]
charset = utf-8
end_of_line = lf
insert_final_newline = true
trim_trailing_whitespace = true
indent_style = space
indent_size = 2

# indentation for python files
[*.py]
indent_size = 4
```

Check https://editorconfig.org/ to get more info.

## Local .vimrc

To override default settings Neovim IDE uses [localvimrc plugin](https://github.com/embear/vim-localvimrc).
It searches for all ".lvimrc" files from the directory of the file up to the root directory.
Example `.lvimrc` to override default python binary:

```vimrc
let g:python3_host_prog = '/path/to/python/binary'
```

Check the plugin "readme" to get more info.

## Local user overrides for Vim and Neovim config

Files `~/.dot-vim.vim` and `~/.dot-nvim.vim` are used to override the global settings of Vim and Neovim.
