#!/usr/bin/env bash
set -euo pipefail

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

if command -v fnm >/dev/null 2>&1; then
  eval "$(fnm env --shell bash)"
fi

corepack_cmd=""
if command -v corepack >/dev/null 2>&1; then
  corepack_cmd="$(command -v corepack)"
fi

if [ -z "$corepack_cmd" ]; then
  echo "corepack not found. Install Node (via fnm) first." >&2
  exit 0
fi

if [[ "$corepack_cmd" == /nix/store/* ]]; then
  echo "corepack is coming from Nix; skipping to avoid Nix store writes." >&2
  exit 0
fi

"$corepack_cmd" enable
"$corepack_cmd" prepare pnpm@latest --activate
