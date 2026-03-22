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
      "cirruslabs/cli/tart"
    ];

    casks = [
      "burp-suite"
      "discord"
      "firefox"
      "google-chrome"
      "moonlight"
      "postman"
      "slack"
      "tailscale-app"
      "ungoogled-chromium"
      "visual-studio-code" 
      "wireshark-app"
    ];

    masApps = {
      "KakaoTalk" = 869223134;
      "Bitwarden" = 1352778147;
    };

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "zap";
    };
  };
}
