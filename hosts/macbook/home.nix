{ username, homeDirectory, ... }:
{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.11";

  imports = [
    ../../modules/home
  ];

  programs.home-manager.enable = true;
}
