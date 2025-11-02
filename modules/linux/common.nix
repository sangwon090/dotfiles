{ inputs, pkgs, ... }:
{
  programs.fish.enable = true;
  
  users.users.sangwon = {
    isNormalUser = true;
    description = "Sangwon Ryu";
    extraGroups = [ "wheel" ];
    shell = pkgs.fish;
  };

}
