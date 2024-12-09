{ ... }: {
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
}   