{ config, lib, pkgs, ... }:
let
  lockfile = ./neovim/lazy-lock.json;
  lazyvimState = ./neovim/lazyvim.json;
  lockDestination = lib.escapeShellArg "${config.xdg.configHome}/nvim/lazy-lock.json";
  lazyvimStateDestination = lib.escapeShellArg "${config.xdg.configHome}/nvim/lazyvim.json";
in
{
  programs.neovim.extraPackages = [ pkgs.fd pkgs.ripgrep ];

  # Keep the LazyVim starter configuration declarative. These files are
  # symlinked from the Nix store, while LazyVim's state files below stay
  # writable so :Lazy update and :LazyExtras keep working.
  xdg.configFile = {
    "nvim/init.lua" = {
      source = ./neovim/init.lua;
      force = true;
    };
    "nvim/lua/config/autocmds.lua" = {
      source = ./neovim/lua/config/autocmds.lua;
      force = true;
    };
    "nvim/lua/config/keymaps.lua" = {
      source = ./neovim/lua/config/keymaps.lua;
      force = true;
    };
    "nvim/lua/config/lazy.lua" = {
      source = ./neovim/lua/config/lazy.lua;
      force = true;
    };
    "nvim/lua/config/options.lua" = {
      source = ./neovim/lua/config/options.lua;
      force = true;
    };
    "nvim/lua/plugins/example.lua" = {
      source = ./neovim/lua/plugins/example.lua;
      force = true;
    };
    "nvim/.gitignore" = {
      source = ./neovim/gitignore;
      force = true;
    };
    "nvim/.neoconf.json" = {
      source = ./neovim/neoconf.json;
      force = true;
    };
    "nvim/stylua.toml" = {
      source = ./neovim/stylua.toml;
      force = true;
    };
  };

  # LazyVim updates these files at runtime, so seed regular writable copies
  # instead of linking them to the read-only Nix store.
  home.activation.seedLazyVimState = lib.hm.dag.entryAfter [ "linkGeneration" ] ''
    if [[ ! -e ${lockDestination} && ! -L ${lockDestination} ]]; then
      run ${pkgs.coreutils}/bin/install -m 0644 ${lockfile} ${lockDestination}
    fi
    if [[ ! -e ${lazyvimStateDestination} && ! -L ${lazyvimStateDestination} ]]; then
      run ${pkgs.coreutils}/bin/install -m 0644 ${lazyvimState} ${lazyvimStateDestination}
    fi
  '';
}
