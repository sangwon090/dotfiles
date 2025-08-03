{ config, lib, pkgs, ... }:

{
  services.desktopManager.gnome = {
    enable = true;
    extraGSettingsOverrides = ''
      [org.gnome.mutter]
      experimental-features = [ 'scale-monitor-framebuffer', 'xwayland-native-scaling' ]
    '';
  };

  services.displayManager.gdm = {
    enable = true;
    wayland = true;
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-connections
    gnome-contacts
    gnome-maps
    gnome-tour
    epiphany
    yelp
  ];
}

