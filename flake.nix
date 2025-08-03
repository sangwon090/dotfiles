{
  description = "Sangwon's Nix Flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    flake-parts.url = "github:hercules-ci/flake-parts";
    home-manager.url = "github:nix-community/home-manager";
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ nixpkgs, flake-parts, home-manager, nix-darwin, ...}:
    let hostsLib = import ./libs/hosts.nix { inherit nixpkgs nix-darwin; };

      nixosHosts = [
        (hostsLib.mkNixosHost {
          name = "vmware";
          system = "x86_64-linux";
          modules = [
            ./system/nixos/common.nix
            ./system/nixos/desktop/common.nix
            ./system/nixos/desktop/vmware/configuration.nix
          ];
        })
        (hostsLib.mkNixosHost {
          name = "pc";
          system = "x86_64-linux";
          modules = [
            ./system/nixos/common.nix
            ./system/nixos/desktop/common.nix
            ./system/nixos/desktop/pc/configuration.nix
          ];
        })
        (hostsLib.mkNixosHost {
          name = "server-intel";
          system = "x86_64-linux";
          modules = [
            ./system/nixos/common.nix
            ./system/nixos/server/common.nix
            ./system/nixos/server/x86_64/common.nix
          ];
        })
        (hostsLib.mkNixosHost {
          name = "server-arm";
          system = "aarch64-linux";
          modules = [
            ./system/nixos/common.nix
            ./system/nixos/server/common.nix
            ./system/nixos/server/aarch64/configuration.nix
          ];
        })
      ];

      darwinHosts = [
        (hostsLib.mkDarwinHost {
          name = "macbook-intel";
          system = "x86_64-darwin";
          modules = [
            ./system/darwin/common.nix
            ./system/darwin/x86_64/configuration.nix
          ];
        })
        (hostsLib.mkDarwinHost {
          name = "macbook-arm";
          system = "aarch64-darwin";
          modules = [
            ./system/darwin/common.nix
            ./system/darwin/aarch64/configuration.nix
          ];
        })
      ];
    
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"   # TODO: steal macbook pro from my mom
        "aarch64-darwin"  # TODO: buy macbook pro right after the discharge
      ];

      flake = {
        nixosConfigurations = builtins.listToAttrs (map (host: {
          name = host.name;
          value = host.config;
        }) nixosHosts);

        darwinConfigurations = builtins.listToAttrs(map (host: {
          name = host.name;
          value = host.config;
        }) darwinHosts);
      };
    };
}
