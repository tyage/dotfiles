#!/usr/bin/env bash

set -euo pipefail

if [[ "$(uname -s)" != "Darwin" ]]; then
  echo "This script only supports macOS." >&2
  exit 1
fi

repo_root="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

if ! command -v brew >/dev/null 2>&1; then
  /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
fi

if [[ -x /opt/homebrew/bin/brew ]]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [[ -x /usr/local/bin/brew ]]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

brew bundle --file "$repo_root/Brewfile"

zsh_path="$(command -v zsh)"
if ! grep -Fxq "$zsh_path" /etc/shells; then
  echo "$zsh_path" | sudo tee -a /etc/shells >/dev/null
fi

if [[ "$SHELL" != "$zsh_path" ]]; then
  chsh -s "$zsh_path"
fi

echo "macOS command-line setup complete."
