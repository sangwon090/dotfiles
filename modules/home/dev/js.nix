{ pkgs, ... }:
{
  home.packages = with pkgs; [
    deno
    nodejs
    pnpm
  ];
}
