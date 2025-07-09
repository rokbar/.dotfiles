{ ... }: {
  homebrew = {
    enable = true;
    casks = [
      "visual-studio-code"
      "rectangle"
      "nordvpn"
      "nordpass"
      "hazeover"
      "raycast"
      "notion"
      "iina"
      "the-unarchiver"
      "ghostty"
      "spotify"
      "chatgpt"
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
