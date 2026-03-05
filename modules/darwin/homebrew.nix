{ ... }:
{
  homebrew = {
    enable = true;
    
    brews = [
      "binwalk"
      "ghidra"
    ];

    casks = [
      "bitwarden"
      "discord"
      "google-chrome"
      "tailscale-app"
      "visual-studio-code" 
    ];

    masApps = {
      "KakaoTalk" = 869223134;
    };

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
  };
}
