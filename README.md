# 📁 .dotfiles

## 🔗 Sources

These .dotfiles are mainly based on these public dotfiles:
- [holman's dotfiles](https://github.com/holman/dotfiles) - picked bootstrap script, idea of building on topics (read below).
- [mathiasbynen's dotfiles](https://github.com/mathiasbynens/dotfile) - picked aliases.

**Update**: introduced **oh-my-zsh** inspired by [this article](https://medium.com/@jackklpan/make-mac-terminal-app-beautiful-and-productive-213f24c0ef4f):

## 📚 Topical

Everything is built on topics. If you're adding a new topic, for example **"git"**, you can create `git` directoy and put files there.
Anything with an extension of `.zsh` will get automatically included into your shell. Anything with an extension of ``.symlink`` will get symlinked without extension into `$HOME` when you run `script/bootstrap`. 

## ✨ Components

There's a few special files in the hierarchy.

- **topic/\*.zsh**: Any files ending in `.zsh` get loaded into your
  environment.
- **topic/path.zsh**: Any file named `path.zsh` is loaded first and is
  expected to setup `$PATH` or similar.
- **topic/install.sh**: Any file named `install.sh` is executed when you run `script/install`. To avoid being loaded automatically, its extension is `.sh`, not `.zsh`.
- **topic/\*.symlink**: Any file ending in `*.symlink` gets symlinked into
  your `$HOME`. This is so you can keep all of those versioned in your dotfiles
  but still keep those autoloaded files in your home directory. These get
  symlinked in when you run `script/bootstrap`.

## 💾 Install

Run this:

```sh
git clone git@github.com:rokbar/.dotfiles.git ~/.dotfiles
cd ~/.dotfiles
script/bootstrap
```

This will symlink the appropriate files in `.dotfiles` to your home directory.
Everything is configured and tweaked within `~/.dotfiles`.

The main file you'll want to change right off the bat is `zsh/zshrc.symlink`,
which sets up a few paths that'll be different on your particular machine.
