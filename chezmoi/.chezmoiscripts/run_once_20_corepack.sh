#!/usr/bin/env bash
set -euo pipefail

if ! command -v corepack >/dev/null 2>&1; then
  echo "corepack not found. Install Node (via Homebrew) first." >&2
  exit 0
fi

corepack enable
corepack prepare pnpm@latest --activate
