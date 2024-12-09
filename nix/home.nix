{ config, pkgs, lib, ... }:

let 
  lsColorScript = pkgs.writeShellScript "ls-color-check" ''
    if ls --color > /dev/null 2>&1; then
      echo "--color"
    else
      echo "-G"
    fi
  '';
  shellAliases = {
    pn = "pnpm";
    # Print processes of specific port, e.g pbp :3005
    pbp = "lsof -i";

    l = "ls -lF $(${lsColorScript})";
    la = "ls -lAF $(${lsColorScript})";
    lsd = "ls -lF $(${lsColorScript}) | grep --color=never '^d'";
    ls = "command ls $(${lsColorScript})";

    path ="echo $PATH | tr ':' '\\n'";
  };
in 
{
  home.username = "rokas";
  home.homeDirectory = "/Users/rokas";

  home.activation = {
    runCustomScript = lib.hm.dag.entryAfter ["writeBoundary"] ''
        $DRY_RUN_CMD echo "Running custom script"
        $DRY_RUN_CMD ${config.home.homeDirectory}/.dotfiles/git/gitconfig_setup.sh
    '';
  };

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "23.05"; # Please read the comment before changing.

    # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages = [
    # # Adds the 'hello' command to your environment. It prints a friendly
    # # "Hello, world!" when run.
    # pkgs.hello

    # # It is sometimes useful to fine-tune packages, for example, by applying
    # # overrides. You can do that directly here, just don't forget the
    # # parentheses. Maybe you want to install Nerd Fonts with a limited number of
    # # fonts?
    # (pkgs.nerdfonts.override { fonts = [ "FantasqueSansMono" ]; })

    # # You can also create simple shell scripts directly inside your
    # # configuration. For example, this adds a command 'my-hello' to your
    # # environment:
    # (pkgs.writeShellScriptBin "my-hello" ''
    #   echo "Hello, ${config.home.username}!"
    # '')
  ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

    # You can also manage environment variables but you will have to manually
  # source
  #
  #  ~/.nix-profile/etc/profile.d/hm-session-vars.sh
  #
  # or
  #
  #  /etc/profiles/per-user/davish/etc/profile.d/hm-session-vars.sh
  #
  # if you don't want to manage your shell through Home Manager.
  home.sessionVariables = {
    # EDITOR = "emacs";
  };

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

  programs.zsh = {
    inherit shellAliases;
    enable = true;
    oh-my-zsh = {
      enable = true;
      plugins = [ 
        "git"
        "autojump"
        "starship"
      ];
      theme = "robbyrussell";
    };
    plugins = [
      {
        name = "zsh-autosuggestions";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-autosuggestions";
          rev = "v0.7.1";
          sha256 = "vpTyYq9ZgfgdDsWzjxVAE7FZH4MALMNZIFyEOBLm5Qo=";
        };
      }
      {
        name = "zsh-syntax-highlighting";
        src = pkgs.fetchFromGitHub {
          owner = "zsh-users";
          repo = "zsh-syntax-highlighting";
          rev = "0.8.0";
          sha256 = "iJdWopZwHpSyYl5/FQXEW7gl/SrKaYDEtTH9cGP7iPo=";
        };
      }
    ];
    initExtra = ''
      eval "$(starship init zsh)"

      # autocomplete
      source <(fnm completions --shell zsh)
    '';
  };
}