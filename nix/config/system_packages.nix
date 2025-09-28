{ pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.vim
    pkgs.wget
    pkgs.jq
    pkgs.ffmpeg
    pkgs.fira-code
    pkgs.fnm
    pkgs.ffmpeg
    pkgs.bitwarden-desktop
    pkgs.pnpm
    pkgs.nodejs_24
    pkgs.mkalias
    pkgs.autojump
    pkgs.starship
    pkgs.claude-code
    pkgs.discord
    pkgs.docker
    pkgs.colima
    pkgs.nodePackages.firebase-tools
  ];
}
