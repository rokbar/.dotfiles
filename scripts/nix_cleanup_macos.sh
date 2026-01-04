#!/usr/bin/env bash
set -euo pipefail

if [ "$(uname -s)" != "Darwin" ]; then
  echo "This script is for macOS only." >&2
  exit 1
fi

echo "This will remove Nix and nix-darwin files from this Mac."
read -r -p "Continue? [y/N] " reply
if [[ "${reply:-}" != "y" ]]; then
  echo "Canceled."
  exit 0
fi

# Stop nix-daemon if present
if [ -f /Library/LaunchDaemons/org.nixos.nix-daemon.plist ]; then
  sudo launchctl bootout system /Library/LaunchDaemons/org.nixos.nix-daemon.plist || true
  sudo rm -f /Library/LaunchDaemons/org.nixos.nix-daemon.plist
fi

# Remove Nix store and config
sudo rm -rf /nix
sudo rm -rf /etc/nix
sudo rm -f /etc/paths.d/nix

# Remove synthetic fs entry for /nix (if present)
if [ -f /etc/synthetic.conf ]; then
  sudo cp /etc/synthetic.conf /etc/synthetic.conf.bak
  sudo /usr/bin/sed -i '' '/^nix$/d' /etc/synthetic.conf
fi

# Remove per-user Nix profiles and caches
rm -rf ~/.nix-profile ~/.nix-defexpr ~/.nix-channels ~/.nix-*
rm -rf ~/.cache/nix 2>/dev/null || true

# Remove root Nix profiles/caches
sudo rm -rf /var/root/.nix-* /var/root/.nix-profile /var/root/.cache/nix 2>/dev/null || true

# Remove nix-darwin current-system symlink if it exists
if [ -e /run/current-system ]; then
  sudo rm -f /run/current-system
fi

echo "Done. Recommended next steps:"
echo "1) Remove Nix lines from /etc/zshrc and /etc/bashrc if present."
echo "2) Reboot to clear synthetic /nix and PATH changes."
