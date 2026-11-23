{ pkgs, ... }:
let
  catppuccin = pkgs.tmuxPlugins.mkTmuxPlugin {
    pluginName = "catppuccin";
    version = "2.3.0";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "tmux";
      rev = "v2.3.0";
      hash = "sha256-3CJRQCgS8NAN7vOLBjNGiHbGXTIrIyY/FLmfZrXcEYc=";
    };
  };

  cpu = pkgs.tmuxPlugins.cpu.overrideAttrs (_: {
    version = "unstable-2024-10-06";
    src = pkgs.fetchFromGitHub {
      owner = "tmux-plugins";
      repo = "tmux-cpu";
      rev = "bcb110d754ab2417de824c464730c412a3eb2769";
      hash = "sha256-OrQAPVJHM9ZACyN36tlUDO7l213tX2a5lewDon8lauc=";
    };
  });
in
{
  programs.tmux = {
    mouse = true;
    terminal = "tmux-256color";

    plugins = [
      pkgs.tmuxPlugins.sensible
      {
        plugin = catppuccin;
        extraConfig = ''
          set -g @catppuccin_flavor "mocha"
          set -g @catppuccin_window_status_style "rounded"
        '';
      }
      {
        plugin = cpu;
        # The CPU and battery plugins rewrite status formats when they load.
        extraConfig = ''
          set -g status-right-length 100
          set -g status-left-length 100
          set -g status-left ""
          set -g status-right "#{E:@catppuccin_status_application}"
          set -agF status-right "#{E:@catppuccin_status_cpu}"
          set -agF status-right "#{E:@catppuccin_status_ram}"
          set -ag status-right "#{E:@catppuccin_status_session}"
          set -ag status-right "#{E:@catppuccin_status_uptime}"
          set -agF status-right "#{E:@catppuccin_status_battery}"
        '';
      }
      pkgs.tmuxPlugins.battery
    ];
  };
}
