{ inputs, ... }: {
  flake.darwinConfiguration = {
    macbook-intel = inputs.nix-darwin.lib.darwinSystem {
      system = "x86_64-darwin";
      modules = [
        ./common.nix
        ./macbook-intel/configuration.nix
      ];
    };

    macbook-arm = inputs.nix-darwin.lib.darwinSystem {
      system = "aarch64-darwin";
      modules = [
        ./common.nix
        ./macbook-arm/configuration.nix
      ];
    };
  };
}
