{ pkgs, ... }:
{
  home.packages = with pkgs; [
    codex
    gemini-cli
  ];
}
