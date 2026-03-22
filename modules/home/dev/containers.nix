{ pkgs, ... }:
{
  home.packages = with pkgs; [
    k3d
    kubectl
    podman
    podman-compose
  ];
}
