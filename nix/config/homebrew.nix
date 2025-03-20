{ ... }: {
  homebrew = {
    enable = true;
    casks = [
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
      "ghostty"
      "spotify"
      "zen-browser"
      "nvidia-geforce-now"
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
