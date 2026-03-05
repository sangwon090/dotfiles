{ username, ... }:
{
  imports = [
    ../../modules/darwin/system.nix
  ];

  system.primaryUser = username;
}
