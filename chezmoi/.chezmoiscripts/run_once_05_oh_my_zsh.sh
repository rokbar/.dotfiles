#!/usr/bin/env bash
set -euo pipefail

zsh_dir="$HOME/.oh-my-zsh"

if [ ! -d "$zsh_dir" ]; then
  git clone https://github.com/ohmyzsh/ohmyzsh.git "$zsh_dir"
fi

zsh_custom="${ZSH_CUSTOM:-$zsh_dir/custom}"
mkdir -p "$zsh_custom/plugins"

if [ ! -d "$zsh_custom/plugins/zsh-autosuggestions" ]; then
  git clone https://github.com/zsh-users/zsh-autosuggestions.git \
    "$zsh_custom/plugins/zsh-autosuggestions"
fi

if [ ! -d "$zsh_custom/plugins/zsh-syntax-highlighting" ]; then
  git clone https://github.com/zsh-users/zsh-syntax-highlighting.git \
    "$zsh_custom/plugins/zsh-syntax-highlighting"
fi
