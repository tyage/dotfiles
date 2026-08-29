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
~/.homesick/repos/dotfiles/scripts/macos.sh
```

## Update

```sh
homesick pull dotfiles
```

The existing symlinks reflect pulled changes immediately. Run
`homesick link dotfiles` interactively only when the repository adds a new
managed path.
