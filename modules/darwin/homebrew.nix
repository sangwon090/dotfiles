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
      "chatgpt"
      "claude-code"
      "discord"
      "firefox"
      "ghostty"
      "google-chrome"
      "hop"
      "microsoft-excel"
      "microsoft-powerpoint"
      "microsoft-word"
      "openusage"
      "raycast"
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
      "RunCat Neo" = 6757801838;
    };

    onActivation = {
      autoUpdate = true;
      upgrade = true;
      cleanup = "none";
    };
  };
}
