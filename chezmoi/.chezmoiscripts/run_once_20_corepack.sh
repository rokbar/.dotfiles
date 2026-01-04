#!/usr/bin/env bash
set -euo pipefail

if [ -x /opt/homebrew/bin/brew ]; then
  eval "$(/opt/homebrew/bin/brew shellenv)"
elif [ -x /usr/local/bin/brew ]; then
  eval "$(/usr/local/bin/brew shellenv)"
fi

corepack_cmd=""
if [ -x /opt/homebrew/opt/node@22/bin/corepack ]; then
  corepack_cmd="/opt/homebrew/opt/node@22/bin/corepack"
elif [ -x /usr/local/opt/node@22/bin/corepack ]; then
  corepack_cmd="/usr/local/opt/node@22/bin/corepack"
elif [ -x /opt/homebrew/bin/corepack ]; then
  corepack_cmd="/opt/homebrew/bin/corepack"
elif [ -x /usr/local/bin/corepack ]; then
  corepack_cmd="/usr/local/bin/corepack"
elif command -v corepack >/dev/null 2>&1; then
  corepack_cmd="$(command -v corepack)"
fi

if [ -z "$corepack_cmd" ]; then
  echo "corepack not found. Install Node (via Homebrew) first." >&2
  exit 0
fi

if [[ "$corepack_cmd" == /nix/store/* ]]; then
  echo "corepack is coming from Nix; skipping to avoid Nix store writes." >&2
  exit 0
fi

"$corepack_cmd" enable
"$corepack_cmd" prepare pnpm@latest --activate
