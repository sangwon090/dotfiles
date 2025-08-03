{ nixpkgs, nix-darwin }:

{
  mkNixosHost = { name, system, modules }:
    {
      inherit name;
      config = nixpkgs.lib.nixosSystem {
        inherit system;
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        inherit modules;
      };
    };
  
  mkDarwinHost = { name, system, modules }:
    {
      inherit name;
      config = nix-darwin.lib.darwinSystem {
        inherit system;
        pkgs = import nixpkgs {
          inherit system;
          config.allowUnfree = true;
        };
        inherit modules;
      };
    };
}