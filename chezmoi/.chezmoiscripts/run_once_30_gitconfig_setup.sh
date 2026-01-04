#!/usr/bin/env bash
set -euo pipefail

if [ -n "${CHEZMOI_SOURCE_DIR:-}" ]; then
  source_dir="$CHEZMOI_SOURCE_DIR"
else
  script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  source_dir="$(cd "${script_dir}/.." && pwd)"
fi
repo_root="$(cd "${source_dir}/.." && pwd)"

"${repo_root}/git/gitconfig_setup.sh"
