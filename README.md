# dotfiles

my dotfiles

[How to setup](https://github.com/tyage/dotfiles/wiki)

## Requirements

- Git
- Ruby 3.2 or later
- Homesick

## Install

```sh
gem install homesick
homesick clone tyage/dotfiles
homesick link dotfiles
```

On macOS, install the command-line tools in `Brewfile` with:

```sh
~/.homesick/repos/dotfiles/scripts/osx.sh
```

## Update

```sh
homesick pull dotfiles
homesick link dotfiles
```
