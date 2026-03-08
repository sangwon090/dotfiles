{ ... }:
{
  programs.starship = {
    enable = true;
    enableFishIntegration = true;
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set -g fish_greeting
    '';
  };

  programs.tmux.enable = true;

  imports = [
    ./vim.nix
  ];
}
