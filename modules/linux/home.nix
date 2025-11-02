{ config, pkgs, ...}:

{
  home.username = "sangwon";
  home.homeDirectory = "/home/sangwon";
  home.stateVersion = "25.05";

  programs.git = {
    enable = true;
    userName = "Sangwon Ryu";
    userEmail = "me@sryu.dev";
  };

  home.packages = with pkgs; [
    neovim
    starship
    rustup
  ];

  programs.starship.enable = true;

}
