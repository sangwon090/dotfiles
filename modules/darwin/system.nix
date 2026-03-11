{ pkgs, username, ... }:
{
  nix.enable = false; # for determinate nix
  system.stateVersion = 4;

  imports = [
    ./homebrew.nix
  ];

  environment.shells = with pkgs; [
    fish
  ];

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.fish;
  };

  fonts = {
    packages = with pkgs; [
      noto-fonts
      noto-fonts-cjk-sans
      noto-fonts-cjk-serif
      nerd-fonts.fira-code
      pretendard
      d2coding
    ];
  };

  networking = {
    wakeOnLan.enable = true;
    knownNetworkServices = [
      "Wi-Fi"
    ];
    dns = [
      "1.1.1.1"
      "1.0.0.1"
    ];
  };

  programs = {
    fish.enable = true;
    tmux.enable = true;
  };

  security = {
    pam.services.sudo_local.touchIdAuth = true;
  };

  system.defaults = {
    controlcenter = {
      BatteryShowPercentage = true;
      Bluetooth = true;
    };

    dock = {
      autohide = false;
      show-recents = false;
      tilesize = 48;
      persistent-apps = [
        { app = "/System/Applications/Apps.app"; }
        { app = "/Applications/Google Chrome.app"; }
        { app = "/Applications/Visual Studio Code.app"; }
        { app = "/Applications/Slack.app"; }
        { app = "/Applications/KakaoTalk.app"; }
        { app = "/Applications/Discord.app"; }
        { app = "/System/Applications/Mail.app"; }
        { app = "/System/Applications/Notes.app"; }
        { app = "/System/Applications/Music.app"; }
        { app = "/System/Applications/Utilities/Terminal.app"; }
        { app = "/System/Applications/System Settings.app"; }
      ];
      persistent-others = [
        { folder = "/Applications/Security/"; }
      ];
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      ShowPathbar = true;
    };

    menuExtraClock = {
      ShowSeconds = true;
    };

    NSGlobalDomain = {
      AppleInterfaceStyleSwitchesAutomatically = true;
      ApplePressAndHoldEnabled = false;
      NSAutomaticDashSubstitutionEnabled = false;
      NSAutomaticPeriodSubstitutionEnabled = false;
      NSAutomaticQuoteSubstitutionEnabled = false;
      NSAutomaticSpellingCorrectionEnabled = false;
    };
  };
}
