{ lib, pkgs, ... }:
let
  codex = pkgs.stdenvNoCC.mkDerivation (finalAttrs: {
    pname = "codex";
    version = "0.162.1";

    src = pkgs.fetchurl {
      url = "https://github.com/openai/codex/releases/download/rust-v${finalAttrs.version}/codex-package-aarch64-apple-darwin.tar.gz";
      hash = "sha256-iON8zd9aD06p3BvhPGaiqU+cLRoE86zpBT1xs5OeiF0=";
    };

    sourceRoot = ".";
    dontBuild = true;
    # Preserve the upstream signatures and paths to the bundled helpers.
    dontFixup = true;

    installPhase = ''
      runHook preInstall
      mkdir -p "$out"
      cp -R bin codex-package.json codex-path codex-resources "$out/"
      runHook postInstall
    '';
  });
in
{
  home.packages = [ codex ];

  # Prefer the pinned CLI when the pnpm global bin directory also has Codex.
  programs.fish.shellInit = lib.mkAfter ''
    fish_add_path --path --move ${codex}/bin
  '';
}
