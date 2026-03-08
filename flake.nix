{
  description = "Sangwon's Nix Configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    
    nix-darwin.url = "github:nix-darwin/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = { self, nixpkgs, nix-darwin, home-manager }:
  let
    mkPkgs = system:
      import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };

    mkLinuxServer = { system, username }:
      home-manager.lib.homeManagerConfiguration {
        pkgs = mkPkgs system;

        modules = [
          ./hosts/server/home.nix
        ]; 

        extraSpecialArgs = {
          inherit username;
          homeDirectory = "/home/${username}";
        };
      };

    mkDarwin = { username }:
      nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        pkgs = mkPkgs "aarch64-darwin";

        modules = [
          ./hosts/macbook
          home-manager.darwinModules.home-manager
          {
            home-manager.extraSpecialArgs = {
              inherit username;
              homeDirectory = "/Users/${username}";
            };

            home-manager.users.${username} = import ./hosts/macbook/home.nix;
          }
        ];

        specialArgs = {
          inherit username;
          homeDirectory = "/Users/${username}";
        };
      };
  in
  {
    # macbook
    darwinConfigurations.macbook = mkDarwin {
      username = "sangwon";
    };

    homeConfigurations = {
      # linux desktop (non-nixos, x86_64)
      linux-desktop = home-manager.lib.homeManagerConfiguration {
        system = "x86_64-linux";
        pkgs = mkPkgs "x86_64-linux";

        modules = [
          ./hosts/desktop/home.nix
        ];

        extraSpecialArgs = {
          username = "sangwon";
        };
      };

      # linux server (non-nixos, x86_64)
      linux-server-x86_64 = mkLinuxServer {
        system = "x86_64-linux";
        username = "sangwon";
      };

      # linux server (non-nixos, aarch64)
      linux-server-aarch64 = mkLinuxServer {
        system = "aarch64-linux";
        username = "sangwon";
      };
    };
  };

  # outputs = { self, nixpkgs, nix-darwin, home-manager }:
  # let
  #   system = "aarch64-darwin";
  # in
  # {
  #   darwinConfigurations."Sangwon-MacBook" = nix-darwin.lib.darwinSystem {
  #     inherit system;

  #     specialArgs = {
  #       username = "sangwon";
  #     };

  #     modules = [
  #       ./hosts/macbook

  #       home-manager.darwinModules.home-manager
  #       ({ pkgs, username, ... }: {
  #         home-manager.useGlobalPkgs = true;
  #         home-manager.useUserPackages = true;

  #         home-manager.extraSpecialArgs = {
  #           inherit username;
  #           homeDirectory = "/Users/${username}";
  #         };

  #         home-manager.users.${username} = import ./home;
  #       })
  #     ];
  #   };
  # };
}
