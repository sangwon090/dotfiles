{ username, homeDirectory ? "/home/${username}", ... }:
{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.11";

  imports = [
    ../../modules/home
    ../../modules/home/dev
    ../../modules/home/llm
  ];

  programs.home-manager.enable = true;
}
