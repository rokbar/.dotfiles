#!/usr/bin/env bash
set -euo pipefail

if ! command -v brew >/dev/null 2>&1; then
  echo "Homebrew not found. Install it first: https://brew.sh" >&2
  exit 1
fi

source_dir="$(chezmoi source-path)"
repo_root="$(cd "${source_dir}/.." && pwd)"
brewfile="${repo_root}/Brewfile"

if [ ! -f "$brewfile" ]; then
  echo "Brewfile not found at $brewfile" >&2
  exit 1
fi

brew update
brew bundle --file "$brewfile"
brew upgrade
brew cleanup

maybe_install() {
  local formula="$1"
  if brew info "$formula" >/dev/null 2>&1; then
    if ! brew list "$formula" >/dev/null 2>&1; then
      brew install "$formula"
    fi
  fi
}

maybe_install "firebase-cli"
maybe_install "firebase-tools"
maybe_install "claude"
maybe_install "claude-code"
