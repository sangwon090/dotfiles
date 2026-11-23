{ ... }:
{
  environment.loginShellInit = ''
    eval "$(/opt/homebrew/bin/brew shellenv)"
  '';

  homebrew = {
    enable = true;
    
    brews = [
      "binwalk"
      "bottom"
      "ffmpeg"
      "ghidra"
      "go"
      "homebrew/core/ipsw"
      "limine"
      "mdcat"
      "opencode"
      "pandoc"
      "qemu"
      "rizin"
      "tree-sitter-cli"
      "typst"
      "wget"
      "ykman"
      "xorriso"
    ];

    casks = [
      "burp-suite"
      "chatgpt"
      "claude-code"
      "discord"
      "firefox"
      "google-chrome"
      "hop"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-word"
      "moonlight"
      "openclaw"
      "openusage"
      "postman"
      "raycast"
      "sage"
      "slack"
      "tailscale-app"
      "ungoogled-chromium"
      "utm"
      "visual-studio-code" 
      "wireshark-app"
      "xquartz"
    ];

    masApps = {
      "KakaoTalk" = 869223134;
      "Bitwarden" = 1352778147;
      "RunCat" = 1429033973;
    };

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "none";
    };
  };
}
