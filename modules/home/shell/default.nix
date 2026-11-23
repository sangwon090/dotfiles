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

    shellInit = ''
      set -gx PNPM_HOME "$HOME/Library/pnpm"
      fish_add_path "$PNPM_HOME"
    '';
  };

  programs.tmux.enable = true;

  programs.neovim = {
    enable = true;
    viAlias = false;
    vimAlias = false;
  };

  imports = [
    ./vim.nix
  ];
}
