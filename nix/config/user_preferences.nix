{ pkgs, ... }: {
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
      "/Applications/Ghostty.app"
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
}
