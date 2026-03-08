{ pkgs, ... }:
{
  home.packages = with pkgs; [
    micromamba
    uv
  ];

  home.sessionVariables = {
    MAMBA_ROOT_PREFIX = "$HOME/.micromamba";
  };

  programs.fish.interactiveShellInit = ''
    eval "$(micromamba shell hook --shell fish)"
  '';

  programs.fish.shellAliases = {
    mamba = "micromamba";
    python = "python3";
  };
}
