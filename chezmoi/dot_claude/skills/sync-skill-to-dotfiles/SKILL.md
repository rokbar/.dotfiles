---
name: sync-skill-to-dotfiles
description: "Sync a Claude Code skill into the user's dotfiles repo for portability via chezmoi. User-invokable only."
disable-model-invocation: true
---

# Sync Skill to Dotfiles

Syncs a referenced Claude Code skill into `~/.dotfiles` so it persists across machines via chezmoi.

## Usage

```
/sync-skill-to-dotfiles <skill-name-or-path>
```

## Process

### 1. Locate the skill

Search for the skill in this order:
1. Project-level: `.claude/skills/<name>/` in the current working directory
2. Global custom: `~/.claude/skills/<name>/` (non-symlink directories)
3. Global third-party: `~/.claude/skills/<name>/` (symlinks into `~/.agents/`)
4. Direct path: if the argument is a path to a SKILL.md or a directory containing one

### 2. Classify the skill

Determine the skill type:

**Third-party (installable via `npx`)**: The skill is a symlink in `~/.claude/skills/` pointing to `~/.agents/skills/`. Look up the skill in `~/.agents/.skill-lock.json` to find the `source` and `sourceType` fields.

**Custom/exact skill**: The skill is a regular directory (not a symlink) containing a `SKILL.md` file. This includes project-level skills and any skill that was written manually.

### 3. Sync to dotfiles

**For third-party skills:**

1. Read `~/.agents/.skill-lock.json` to find the install source (e.g., `firstnamelastname/skills` with `skillPath` `write-a-skill/SKILL.md`)
2. Reconstruct the install command: `npx @anthropic-ai/claude-code skills add <source>/<skill-folder>`
   - The install argument is: `<source>/<skillPath without /SKILL.md>`
   - Example: source `firstnamelastname/skills`, skillPath `write-a-skill/SKILL.md` → `firstnamelastname/skills/write-a-skill`
3. Check if this command already exists in `~/.dotfiles/chezmoi/run_onchange_install-claude-skills.sh`
4. If not present, append the install command and update the comment list in the script header
5. Report what was added

**For custom/exact skills:**

1. Copy the entire skill directory (SKILL.md and any supporting files) to `~/.dotfiles/chezmoi/dot_claude/skills/<skill-name>/`
2. If the skill already exists there, show a diff and ask the user to confirm overwrite
3. Report what was synced

### 4. Confirm

Print a summary:
- Skill name and type (third-party or custom)
- What was done (added install command or copied files)
- File(s) modified in `~/.dotfiles/`
