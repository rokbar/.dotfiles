{ pkgs, config, ... }:
{
  programs.zsh = {
    enable = true;
    shellAliases = config.home.shellAliases;
    oh-my-zsh = {
      enable = true;
      plugins = [ "git" "autojump" "starship" ];
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
      source <(fnm completions --shell zsh)
    '';
  };
}
