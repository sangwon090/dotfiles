{ username, homeDirectory, lib, pkgs, ... }:
let
  rustup = lib.getExe pkgs.rustup;
in
{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "25.11";

  imports = [
    ../../modules/home
    ../../modules/home/dev
    ../../modules/home/llm
    ./codex.nix
    ./neovim.nix
    ./tmux.nix
  ];

  xdg.configFile."ghostty/config".source = ./ghostty/config;

  home.activation.initializeRustToolchain = lib.hm.dag.entryAfter [ "writeBoundary" ] ''
    if [[ -z "''${DRY_RUN:-}" ]] && ! ${rustup} default >/dev/null 2>&1; then
      run ${rustup} default stable
    fi
  '';

  programs.home-manager.enable = true;
}
