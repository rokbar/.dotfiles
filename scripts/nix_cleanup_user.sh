#!/usr/bin/env bash
set -euo pipefail

if [ "$(uname -s)" != "Darwin" ]; then
  echo "This script is for macOS only." >&2
  exit 1
fi

echo "This will remove user-level Nix leftovers from $HOME."
read -r -p "Continue? [y/N] " reply
if [[ "${reply:-}" != "y" ]]; then
  echo "Canceled."
  exit 0
fi

# Remove user profiles and caches
rm -rf "$HOME/.nix-profile" \
  "$HOME/.nix-defexpr" \
  "$HOME/.nix-channels" \
  "$HOME/.nix-"* \
  "$HOME/.cache/nix" \
  "$HOME/.local/state/nix" 2>/dev/null || true

# Remove .zshenv if it points to /nix/store
if [ -L "$HOME/.zshenv" ]; then
  zshenv_target="$(readlink "$HOME/.zshenv" || true)"
  if [[ "$zshenv_target" == /nix/store/* ]]; then
    rm -f "$HOME/.zshenv"
  fi
fi

# Optional removal of ~/nix if it exists
if [ -d "$HOME/nix" ]; then
  echo "Found $HOME/nix"
  read -r -p "Remove $HOME/nix? [y/N] " remove_nix_dir
  if [[ "${remove_nix_dir:-}" == "y" ]]; then
    rm -rf "$HOME/nix"
  fi
fi

echo "Done. If you still see Nix in your shell, remove any Nix PATH lines from /etc/zshrc or /etc/bashrc."
