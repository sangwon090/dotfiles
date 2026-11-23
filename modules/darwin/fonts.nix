{ pkgs, ... }:
let
  pretendard = pkgs.pretendard.overrideAttrs (old: {
    postInstall = (old.postInstall or "") + ''
      install -Dm644 public/variable/PretendardVariable.ttf -t "$out/share/fonts/truetype"
    '';
  });

  wantedSansVersion = "1.0.3";
  wantedSans = pkgs.runCommand "wanted-sans-${wantedSansVersion}" {
    nativeBuildInputs = [ pkgs.unzip ];
    src = pkgs.fetchurl {
      url = "https://github.com/wanteddev/wanted-sans/releases/download/v${wantedSansVersion}/WantedSans-${wantedSansVersion}.zip";
      hash = "sha256-4HNMHilCbSpiE2UDg/7DcFEUX8yu2DYMj+MNdTIdmKs=";
    };
  } ''
    unzip -q "$src" 'ttf/*.ttf' 'variable/*.ttf' OFL.txt
    install -Dm644 ttf/*.ttf variable/*.ttf -t "$out/share/fonts/truetype"
    install -Dm644 OFL.txt "$out/share/licenses/wanted-sans/OFL.txt"
  '';
in
{
  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-cjk-serif
    nerd-fonts.fira-code
    pretendard
    wantedSans
    d2coding
  ];
}
