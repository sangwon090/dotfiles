{ config, lib, pkgs, ... }:

{
  users.users.sangwon = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
    packages = with pkgs; [
      vim
      git
    ];
  };

  documentation.nixos.enable = false;
}
