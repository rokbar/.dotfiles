#!/bin/bash
# Claude Code skills to install globally.
# Modify this list to trigger chezmoi re-run.
#
# Skills:
# - mattpocock/skills/write-a-skill
# - vercel-labs/skills/skills/find-skills

set -e

if ! command -v npx &>/dev/null; then
  echo "npx not found, skipping Claude skills installation"
  exit 0
fi

echo "Installing Claude Code skills..."

npx @anthropic-ai/claude-code skills add mattpocock/skills/write-a-skill 2>/dev/null || true
npx @anthropic-ai/claude-code skills add vercel-labs/skills/skills/find-skills 2>/dev/null || true

echo "Claude Code skills installed."
