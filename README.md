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

This applies the managed dotfiles and app configs, including the Ghostty
macOS config at `~/Library/Application Support/com.mitchellh.ghostty/config`.
Ghostty itself is installed from the `Brewfile`, so no extra setup step is
needed beyond `chezmoi apply`.

6. Sign into the App Store (required for mas apps), then re-run:

```sh
chezmoi apply
```

7. Restart or log out/in to ensure macOS defaults and Dock changes take effect.

### Install new items from Brewfile (without upgrading)

If you add new entries to `Brewfile` and only want to install the missing ones:

```sh
brew bundle --file Brewfile
```

This installs packages that are not already installed and does not upgrade existing ones. To also upgrade, use:

```sh
brew bundle --file Brewfile --upgrade
```

## Ghostty

Ghostty is managed by `chezmoi` from
`chezmoi/private_Library/private_Application Support/com.mitchellh.ghostty/config`
to `~/Library/Application Support/com.mitchellh.ghostty/config`.

On macOS, Ghostty can also read an XDG config path under `~/.config/ghostty/`.
Keep only one non-empty Ghostty config path to avoid ambiguity about which file
Ghostty is loading.
