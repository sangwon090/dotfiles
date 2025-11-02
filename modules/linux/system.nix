{ inputs, ... }: {
  flake.nixosConfigurations = {
    pc = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./common.nix
      ];
    };

    vm = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ../../hosts/nixos-vm/configuration.nix
        ./common.nix
        ./system/gnome.nix

        inputs.home-manager.nixosModules.home-manager {
          home-manager.useGlobalPkgs = true;
          home-manager.useUserPackages = true;
          home-manager.users.sangwon = import ./home.nix;
        }
      ];
    };

    server-intel = inputs.nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./common.nix
      ];
    };

    server-arm = inputs.nixpkgs.lib.nixosSystem {
      system = "aarch64-linux";
      modules = [
        ./common.nix
      ];
    };
  };
}
