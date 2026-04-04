{ pkgs, ... }:
{
  version ? "5.8",
  ...
}@inputs:
let
  configPatch = pkgs.replaceVars ./fix-config.patch { inherit version; };
in
pkgs.stdenv.mkDerivation {
  inherit version;
  pname = "Orange hrm";
  src = pkgs.fetchzip {
    url = "https://github.com/orangehrm/orangehrm/releases/download/v${version}/orangehrm-${version}.zip";
    sha256 = "rG8uWdQ8mnwcpKtGwKrctyk8lL2TaTTlJ+naCxxGHsA=";
    stripRoot = false;
  };

  patches = [ configPatch ];

  installPhase = ''
    mkdir -p $out
    cp -r orangehrm-${version}/* $out/
  '';
}
