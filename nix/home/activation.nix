{ pkgs, lib, config, ... }:
{
  home.activation = {
    runCustomScript = lib.hm.dag.entryAfter ["writeBoundary"] ''
        $DRY_RUN_CMD echo "Running custom script"
        $DRY_RUN_CMD ${config.home.homeDirectory}/.dotfiles/git/gitconfig_setup.sh
    '';
  };
}
