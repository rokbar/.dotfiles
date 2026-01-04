# 📁 .dotfiles

## 🍺 Homebrew + chezmoi

### Fresh macOS setup

1. Install Xcode Command Line Tools:

```sh
xcode-select --install
```

2. Install Homebrew:

```sh
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

3. Clone this repo:

```sh
git clone <YOUR_REPO_URL> ~/.dotfiles
cd ~/.dotfiles
```

4. Install chezmoi:

```sh
brew install chezmoi
```

5. Initialize chezmoi from the repo and apply:

```sh
chezmoi init --source ./chezmoi
chezmoi apply
```

6. Sign into the App Store (required for mas apps), then re-run:

```sh
chezmoi apply
```

7. Restart or log out/in to ensure macOS defaults and Dock changes take effect.

## ✨ Nix

Moving from Homebrew-based dotfiles (`homebrew` branch) to Nix-based dotfiles offers several compelling advantages, including a declarative approach to configuration management, improved reproducibility across different systems, and the ability to manage both packages and dotfiles within a single, unified framework.

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
