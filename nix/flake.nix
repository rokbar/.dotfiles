{
  description = "M1 Pro nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew, home-manager }:
  let
    configuration = { pkgs, config, ... }: {

      nixpkgs.config.allowUnfree = true;
      
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [ 
          pkgs.vim
          pkgs.wget
          pkgs.jq
          pkgs.fira-code
          pkgs.fnm
          pkgs.pnpm
          pkgs.mkalias
          pkgs.autojump
          pkgs.starship
        ];

      homebrew = {
        enable = true;
        casks = [
          "arc"
          "visual-studio-code"
          "rectangle"
          "nordvpn"
          "nordpass"
          "docker"
          "hazeover"
          "raycast"
          "notion"
          "iina"
          "the-unarchiver"
        ];
	      masApps = {
          "Yoink" = 457622435;
          "Perplexity" = 6714467650;
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = "/Applications";
        };
      in
        pkgs.lib.mkForce ''
        # Set up applications.
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
          echo "copying $src" >&2
          ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
        done
            '';

      # Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";
      programs.zsh.enable = true;
      system.configurationRevision = self.rev or self.dirtyRev or null;
      # Used for backwards compatibility, please read the changelog before changing.
      # $ darwin-rebuild changelog
      system.stateVersion = 5;
      # The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

      home-manager.backupFileExtension = "backup";
      users.users.rokas.home = "/Users/rokas";

      system.defaults = {
        finder.FXPreferredViewStyle = "clmv";
        loginwindow.GuestEnabled = false;
        
        NSGlobalDomain."com.apple.keyboard.fnState" = true;
        NSGlobalDomain.AppleInterfaceStyle = "Dark";
        NSGlobalDomain.AppleICUForce24HourTime = true;
        NSGlobalDomain.NSTableViewDefaultSizeMode = 2;

        dock.autohide = true;
        dock.show-recents = false;
        dock.tilesize = 42;
        dock.static-only = true;
        dock.persistent-apps = [
          "/Applications/Arc.app"
          "/Applications/Notion.app"
          "/System/Applications/Calendar.app"
          "/Applications/NordPass.app"
        ];

        CustomUserPreferences = {
          "com.apple.symbolichotkeys" = {
            AppleSymbolicHotKeys = {
              # Show Launchpad -> Command + Option + L
              "160" = { enabled = true; value = { parameters = [ 108 37 1572864 ]; type = "standard"; }; };
              # Disable Show Desktop with F11
              "36" = { enabled = false; value = { parameters = [ 65535 103 8388608 ]; type = "standard"; }; };
              "37" = { enabled = false; value = { parameters = [ 65535 103 8519680 ]; type = "standard"; }; };
            };
          };
        };
      };
    };
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#simple
    darwinConfigurations."m1pro" = nix-darwin.lib.darwinSystem {
      modules = [ 
        configuration
        nix-homebrew.darwinModules.nix-homebrew {
          nix-homebrew = {
            # Install Homebrew under the default prefix
            enable = true;

            # Apple Silicon Only
            enableRosetta = true;
            # User owning the Homebrew prefix
            user = "rokas";
          };
        }
        home-manager.darwinModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.rokas = import ./home.nix;
        }
      ];
    };
  };
}