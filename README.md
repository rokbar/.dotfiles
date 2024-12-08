# 📁 .dotfiles

## ✨ Nix

Moving from Homebrew-based dotfiles (`homebrew` branch) to Nix-based dotfiles offers several compelling advantages, including a declarative approach to configuration management, improved reproducibility across different systems, and the ability to manage both packages and dotfiles within a single, unified framework.

This transition allows for more robust version control, easier sharing of configurations, and the potential to create isolated development environments, ultimately leading to a more streamlined and consistent setup process across multiple machines

### Setup

1. Install Nix:

```sh
sh <(curl -L https://nixos.org/nix/install)
```

2. Run nix-darwin and switch to a new configuration defined in `flake.nix`:

```sh
nix run nix-darwin --extra-experimental-features "nix-command flakes" -- switch --flake ~/nix#m1pro
```

3. On `flakes` configuration update run:

```sh
nix flake update
darwin-rebuild switch --flake ~/nix#m1pro
```

## 💾 Git

Run this:

```sh
git clone git@github.com:rokbar/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```
