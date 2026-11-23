{ config, lib, pkgs, ... }:
let
  lockfile = ./neovim/lazy-lock.json;
  plugins = builtins.fromJSON (builtins.readFile lockfile);
  lockDestination = lib.escapeShellArg "${config.xdg.configHome}/nvim/lazy-lock.json";
in
{
  programs.neovim = {
    extraPackages = [ pkgs.fd pkgs.ripgrep ];
    initLua = lib.replaceStrings
      [ "@git@" "@lazyNvimRevision@" "@lazyVimRevision@" ]
      [ (lib.getExe pkgs.git) plugins."lazy.nvim".commit plugins.LazyVim.commit ]
      (builtins.readFile ./neovim/init.lua);
  };

  # Lazy writes this file when installing or updating plugins.
  home.activation.seedLazyLock = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    if [[ ! -e ${lockDestination} && ! -L ${lockDestination} ]]; then
      run ${pkgs.coreutils}/bin/install -m 0644 ${lockfile} ${lockDestination}
    fi
  '';
}
