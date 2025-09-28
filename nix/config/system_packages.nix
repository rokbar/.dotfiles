{ pkgs, ... }: {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = [
    pkgs.vim
    pkgs.wget
    pkgs.jq
    pkgs.fira-code
    pkgs.fnm
    pkgs.ffmpeg
    pkgs.bitwarden-desktop
    pkgs.pnpm
    pkgs.nodejs
    pkgs.mkalias
    pkgs.autojump
    pkgs.starship
    pkgs.claude-code
    pkgs.discord
    pkgs.docker
    pkgs.colima
  ];
}
