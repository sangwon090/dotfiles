{ ... }:
{
  environment.loginShellInit = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';

  homebrew = {
    enable = true;
    
    brews = [
      "binwalk"
      "ghidra"
    ];

    casks = [
      "bitwarden"
      "burp-suite"
      "discord"
      "google-chrome"
      "postman"
      "slack"
      "tailscale-app"
      "visual-studio-code" 
      "wireshark-app"
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
