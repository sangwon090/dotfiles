{ lib, pkgs, username, ... }:
{
  nix.enable = false; # for determinate nix
  system.stateVersion = 4;

  imports = [
    ./fonts.nix
    ./homebrew.nix
  ];

  environment.shells = with pkgs; [
    fish
  ];

  users.users.${username} = {
    home = "/Users/${username}";
    shell = pkgs.fish;
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
      persistent-others = [
        {
          folder = {
            path = "/Users/${username}/Downloads";
            arrangement = "date-added";
            displayas = "stack";
            showas = "fan";
          };
        }
      ];
    };

    finder = {
      AppleShowAllExtensions = true;
      AppleShowAllFiles = true;
      FXPreferredViewStyle = "Nlsv";
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

  # Apply pins after Homebrew, when newly installed apps are available.
  system.activationScripts.postActivation.text = let
    dockApps = [
      "/System/Applications/Apps.app"
      "/Applications/Firefox.app"
      "/Applications/Chromium.app"
      "/Applications/KakaoTalk.app"
      "/Applications/Visual Studio Code.app"
      "/Applications/Slack.app"
      "/Applications/Discord.app"
      "/System/Applications/Messages.app"
      "/System/Applications/Notes.app"
      "/System/Applications/Mail.app"
      "/System/Applications/Music.app"
      "/Applications/Microsoft Word.app"
      "/Applications/Microsoft Excel.app"
      "/Applications/Microsoft PowerPoint.app"
      "/Applications/Ghostty.app"
      "/Applications/Bitwarden.app"
      "/System/Applications/iPhone Mirroring.app"
      "/System/Applications/System Settings.app"
      "/Applications/IDA Professional 9.4.app"
      "/Applications/Binary Ninja.app"
    ];
    dockTile = app: lib.generators.toPlist { escape = true; } {
      tile-data.file-data = {
        _CFURLString = app;
        _CFURLStringType = 0;
      };
    };
    user = lib.escapeShellArg username;
  in ''
    dockAppTiles=()
    ${lib.concatMapStrings (app: ''
      if [[ -d ${lib.escapeShellArg app} ]]; then
        dockAppTiles+=(${lib.escapeShellArg (dockTile app)})
      fi
    '') dockApps}
    launchctl asuser "$(id -u -- ${user})" sudo --user=${user} -- \
      defaults write com.apple.dock persistent-apps -array "''${dockAppTiles[@]}"
    killall -qu ${user} Dock || true
  '';
}
