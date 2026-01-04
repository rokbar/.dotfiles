#!/usr/bin/env bash
set -euo pipefail

source_dir="$(chezmoi source-path)"
repo_root="$(cd "${source_dir}/.." && pwd)"

"${repo_root}/git/gitconfig_setup.sh"
